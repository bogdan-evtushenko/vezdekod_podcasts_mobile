package com.example.vkpodcasts

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_create_new_podcast.*
import java.io.IOException

class CreateNewPodcastActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_create_new_podcast)

        btnUpload.setOnClickListener {
            val REQ_PICK_AUDIO = 10001
            val audio_picker_intent = Intent(
                Intent.ACTION_PICK,
                MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
            )
            startActivityForResult(audio_picker_intent, REQ_PICK_AUDIO)
        }

        imageCardView.setOnClickListener {
            chooseImage()
        }
    }

    private fun chooseImage() {
        val intent = Intent()
        intent.type = "image/*"
        intent.action = Intent.ACTION_GET_CONTENT
        startActivityForResult(
            Intent.createChooser(intent, "Select Picture"),
            1
        )
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 1 && resultCode == Activity.RESULT_OK && data != null && data.data != null) {
            val filePath = data.data
            try {
                val bitmap =
                    MediaStore.Images.Media.getBitmap(contentResolver, filePath)
                stub.visibility = View.INVISIBLE
                image.setImageBitmap(bitmap)
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }
    }
}