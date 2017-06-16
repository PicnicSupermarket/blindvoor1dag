package menegatti.accessibility101

import android.os.Bundle
import android.support.design.widget.BottomNavigationView
import android.support.v4.app.Fragment
import android.support.v7.app.AppCompatActivity
import android.view.View

class MainActivity : AppCompatActivity() {

    private lateinit var navigationView: BottomNavigationView

    private val mOnNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
        when (item.itemId) {
            R.id.navigation_basic -> {
                showBasicFragment()
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_dynamic -> {
                showDynamicFragment()
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_custom -> {
                showCustomViewFragment()
                return@OnNavigationItemSelectedListener true
            }
        }
        false
    }

    private fun showBasicFragment() {
        setFragment(BasicFragment())
    }

    private fun showDynamicFragment() {
        setFragment(DynamicFragment())
    }

    private fun showCustomViewFragment() {
        setFragment(CustomViewFragment())
    }

    private fun setFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
                .replace(R.id.content, fragment, fragment.javaClass.name)
                .commit()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        navigationView = findViewById(R.id.navigation)
        navigationView.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
        navigationView.findViewById<View>(R.id.navigation_basic).performClick()
    }
}