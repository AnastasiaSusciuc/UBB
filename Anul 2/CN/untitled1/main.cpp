#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

fd_set master;
fd_set read_fds;
int others_port_arr[500];
int len_others_arr = 0;
int fdmax = 0;
int main() {
    int tcp_server_sock, udp_recv_sock, udp_send_sock;
    struct sockaddr_in server_addr, current_addr;
    struct sockaddr_in send_to_addr, recv_from_addr;
    int len_addr;
    len_addr = sizeof(struct sockaddr_in);

    tcp_server_sock = socket(AF_INET, SOCK_STREAM, 0);
    if(tcp_server_sock < 0) {
        perror("Error on creating tcp_server_sock");
        exit(1);
    }

    udp_send_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if(udp_send_sock < 0) {
        close(tcp_server_sock);
        perror("Error on creating udp_send_sock");
        exit(1);
    }

    udp_recv_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if(udp_recv_sock < 0) {
        close(tcp_server_sock);
        close(udp_send_sock);
        perror("Error on creating udp_recv_sock");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = inet_addr("192.168.1.185");
    server_addr.sin_port = htons(2020);

    if(connect(tcp_server_sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        close(tcp_server_sock);
        close(udp_send_sock);
        close(udp_recv_sock);
        perror("Error on connecting to server");
        exit(1);
    }

    struct sockaddr_in dummy_addr;
    dummy_addr.sin_family = AF_INET;
    dummy_addr.sin_addr.s_addr = inet_addr("192.168.1.23");
    dummy_addr.sin_port = htons(7734);
    sendto(udp_recv_sock, "dummy", 10, 0, (struct sockaddr*)&dummy_addr, sizeof(dummy_addr));

    getsockname(udp_recv_sock, (struct sockaddr*)&current_addr, (socklen_t*)&len_addr);
    int udp_recv_port;
    udp_recv_port = current_addr.sin_port;
    if(send(tcp_server_sock, &udp_recv_port, sizeof(udp_recv_port), 0) < 0) {
        close(tcp_server_sock);
        close(udp_send_sock);
        close(udp_recv_sock);
        perror("Error on sending port");
        exit(1);
    }

//    printf("%s, %d\n", inet_ntoa(current_addr.sin_addr), ntohs(current_addr.sin_port));
//    char recv_buffer[1024];
//    char send_msg[300] = "You can't eat your cake and have it too.";
//    sendto(udp_send_sock, send_msg, strlen(send_msg) + 1, 0, (struct sockaddr*)&current_addr, len_addr);
//
//    if(recvfrom(udp_recv_sock, recv_buffer, 1024, 0, (struct sockaddr*)&recv_from_addr, (socklen_t*)&len_addr) <= 0) {
//        perror("Error on recv");
//    }
//    printf("%s\n", recv_buffer);

    FD_ZERO(&master);
    FD_ZERO(&read_fds);
    FD_SET(0, &master);
    FD_SET(tcp_server_sock, &master);
    FD_SET(udp_recv_sock, &master);

    if(tcp_server_sock > udp_recv_sock) {
        fdmax = tcp_server_sock;
    } else {
        fdmax = udp_recv_sock;
    }
    char port_to_send_arr[30];
    int port_to_send_netf;
    char message_to_send[512];
    char buffer_input[1024];
    long nbytes;
    for(;;) {
        read_fds = master;
        if(select(fdmax + 1, &read_fds, NULL, NULL, NULL) < 0) {
            close(tcp_server_sock);
            close(udp_send_sock);
            close(udp_recv_sock);
            perror("Error on select");
            exit(1);
        }
        if(FD_ISSET(0, &read_fds)) {
            nbytes = read(0, buffer_input, sizeof(buffer_input) - 1);

            int idx = 0;
            char* token = strtok(buffer_input, ";");
            while (token != NULL) {
                if(idx == 0) {
                    strcpy(port_to_send_arr, token);
                } else if(idx == 1){
                    strcpy(message_to_send, token);
                }
                idx++;
                token = strtok(NULL, ";");
            }
            port_to_send_netf = htons(atoi(port_to_send_arr));

            int ok = 0;
            for(int i = 0; i <= len_others_arr; i++) {
                if (others_port_arr[i] == port_to_send_netf) {
                    ok = 1;
                }
            }
            if(ok == 0) {
                printf("There is no client with the port %d\n", ntohs(port_to_send_netf));
            } else {
                send_to_addr.sin_family = AF_INET;
                send_to_addr.sin_addr.s_addr = inet_addr("0.0.0.0");
                send_to_addr.sin_port = port_to_send_netf;

                if (sendto(udp_send_sock, message_to_send, strlen(message_to_send) + 1, 0,
                           (struct sockaddr *) &send_to_addr, len_addr) < 0) {
                    close(tcp_server_sock);
                    close(udp_send_sock);
                    close(udp_recv_sock);
                    perror("Error on sending message");
                    exit(1);
                }
            }
        } else if(FD_ISSET(tcp_server_sock, &read_fds)) {
            char connect_disconnect_char;
            int new_port_netf;

            if(recv(tcp_server_sock, &connect_disconnect_char, sizeof(connect_disconnect_char), 0) < 0) {
                close(tcp_server_sock);
                close(udp_send_sock);
                close(udp_recv_sock);
                perror("Error on receive new port");
                exit(1);
            }

            if(recv(tcp_server_sock, &new_port_netf, sizeof(new_port_netf), 0) < 0) {
                close(tcp_server_sock);
                close(udp_send_sock);
                close(udp_recv_sock);
                perror("Error on receive new port");
                exit(1);
            }

            if(connect_disconnect_char == 'c') {
                printf("New client connected with port: %d\n", ntohs(new_port_netf));
                others_port_arr[len_others_arr] = new_port_netf;
                len_others_arr++;
            } else if(connect_disconnect_char == 'd') {
                printf("The client disconnected with port: %d\n", ntohs(new_port_netf));
                for(int i = 0; i <= len_others_arr; i++) {
                    if(others_port_arr[i] == new_port_netf) {
                        others_port_arr[i] = -1;
                    }
                }
            }
        } else if(FD_ISSET(udp_recv_sock, &read_fds)) {
            char buffer_answer[1024];
            if(recvfrom(udp_recv_sock, buffer_answer, 1024, 0, (struct sockaddr*)&recv_from_addr, (socklen_t*)&len_addr) < 0) {
                close(tcp_server_sock);
                close(udp_send_sock);
                close(udp_recv_sock);
                perror("Error on receive answer");
                exit(1);
            }
            printf("Received message: \"%s\" from: (%s, %d)\n", buffer_answer, inet_ntoa(recv_from_addr.sin_addr),
                   ntohs(recv_from_addr.sin_port));
        }
    }

    return 0;
}