package com.example.makotlin2

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

//val image: Int, val first_name: String, val last_name: String, val subject: String, val description: String
class ItemsViewModel: ViewModel() {
    var firstNames = MutableLiveData<String>()
    var lastNames = MutableLiveData<String>()
    var yearsOfExperiences = MutableLiveData<String>()
    var subjects = MutableLiveData<String>()
    var descriptions = MutableLiveData<String>()

}
