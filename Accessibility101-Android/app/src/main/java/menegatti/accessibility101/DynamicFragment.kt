package menegatti.accessibility101

import android.content.Context
import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v4.view.ViewCompat
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.accessibility.AccessibilityManager
import android.widget.Button

class DynamicFragment : Fragment() {

    lateinit var firstAnnounceButton: Button
    lateinit var secondAnnounceButton: Button

    lateinit var firstLiveRegionButton: Button
    lateinit var secondLiveRegionButton: Button

    lateinit var goneButton: Button

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater?.inflate(R.layout.fragment_dynamic, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        configureAnnouncement(view)
        configureLiveRegion(view)

        goneButton = view.findViewById(R.id.second_button_accessibility_visibility)
        val accessibilityManager = context.getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
        if (accessibilityManager.isEnabled) {
            goneButton.visibility = View.INVISIBLE
        }
    }

    private fun configureAnnouncement(view: View) {
        firstAnnounceButton = view.findViewById(R.id.first_button_announce)
        secondAnnounceButton = view.findViewById(R.id.second_button_announce)

        firstAnnounceButton.setOnClickListener {
            secondAnnounceButton.visibility = if (secondAnnounceButton.visibility == View.GONE) {
                secondAnnounceButton.announceForAccessibility(secondAnnounceButton.text.toString() + " button is now on screen")
                View.VISIBLE
            } else {
                secondAnnounceButton.announceForAccessibility(secondAnnounceButton.text.toString() + " button leaving screen")
                View.GONE
            }
        }
        secondAnnounceButton.setOnClickListener {
            (it as Button).text = "I've been clicked"
            secondAnnounceButton.announceForAccessibility("Button text is now I've been clicked")
        }
    }

    private fun configureLiveRegion(view: View) {
        firstLiveRegionButton = view.findViewById(R.id.first_button_live_region)
        secondLiveRegionButton = view.findViewById(R.id.second_button_live_region)
        ViewCompat.setAccessibilityLiveRegion(secondLiveRegionButton, ViewCompat.ACCESSIBILITY_LIVE_REGION_POLITE)

        firstLiveRegionButton.setOnClickListener {
            secondLiveRegionButton.visibility = if (secondLiveRegionButton.visibility == View.GONE) {
                View.VISIBLE
            } else {
                View.GONE
            }
        }
        secondLiveRegionButton.setOnClickListener { (it as Button).text = "I've been clicked" }
    }
}