package com.example.makotlin2

import android.content.SharedPreferences
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity


class AddActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_teacher)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        val data = ArrayList<ItemsViewModel>()

        val saveButton = findViewById<Button>(R.id.buttonSave)
        saveButton.setOnClickListener {
            val firstName = R.id.etFirstName.toString()
//            data.add(ItemsViewModel(R.drawable.teacher, firstName, firstName, "s", "gg"))
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
        }

    }
}