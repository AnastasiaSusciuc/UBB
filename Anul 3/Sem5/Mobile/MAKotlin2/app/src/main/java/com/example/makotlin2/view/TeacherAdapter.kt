package com.example.makotlin2.view

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.makotlin2.R
import com.example.makotlin2.model.Teacher
import com.google.android.material.textfield.TextInputEditText
import org.w3c.dom.Text

class TeacherAdapter(val c: Context, teacherList: ArrayList<Teacher>): RecyclerView.Adapter<TeacherAdapter.TeacherViewHolder>() {

    inner class TeacherViewHolder(val v: View): RecyclerView.ViewHolder(v) {
        val firstName = v.findViewById<TextView>(R.id.etFirstName)
        val lastName = v.findViewById<TextView>(R.id.etLastName)
        val subject = v.findViewById<TextView>(R.id.etSubject)
        val yearsEx = v.findViewById<TextView>(R.id.etYearsExperience)
        val desc = v.findViewById<TextView>(R.id.etDescription)

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TeacherViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val v  = inflater.inflate(R.layout.activity_add_teacher, parent,false)
        return TeacherViewHolder(v)
    }

    override fun onBindViewHolder(holder: TeacherViewHolder, position: Int) {
        TODO("Not yet implemented")
    }

    override fun getItemCount(): Int {
        TODO("Not yet implemented")
    }

}