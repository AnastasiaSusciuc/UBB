package com.example.makotlin2

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.makotlin2.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var teacherViewModel: ItemsViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val recyclerview = findViewById<RecyclerView>(R.id.rvTeacherList)
        recyclerview.layoutManager = LinearLayoutManager(this)

        val data = ArrayList<ItemsViewModel>()

//        for (i in 1..20) {
//            data.add(ItemsViewModel(R.drawable.teacher, "Item $i", "s", "s", "gg"))
//        }

        // This will pass the ArrayList to our Adapter
        val adapter = CustomAdapter(data)

        // Setting the Adapter with the recyclerview
        recyclerview.adapter = adapter

        teacherViewModel = ViewModelProvider(this).get(ItemsViewModel::class.java)
//        teacherViewModel.firstNames.observe(this) {
//            binding.
//        }
//        binding.addButton.setOnClickListener {
//            AddActivity().show(supportFragmentManager, "dd")
//        }


        val addButton = findViewById<Button>(R.id.addButton)
        addButton.setOnClickListener {
            val intent = Intent(this, AddActivity::class.java)
            startActivity(intent)
        }


    }
}