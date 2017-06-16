package menegatti.accessibility101

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import menegatti.accessibility101.view.price.AccessiblePriceView
import menegatti.accessibility101.view.price.ContentDescriptionPriceView
import menegatti.accessibility101.view.price.CustomActionAccessiblePriceView
import menegatti.accessibility101.view.price.RegularPriceView

class CustomViewFragment : Fragment() {

    lateinit var regularPriceView: RegularPriceView
    lateinit var contentDescriptionPriceView: ContentDescriptionPriceView
    lateinit var accessiblePriceView: AccessiblePriceView
    lateinit var customActionAccessiblePriceView: CustomActionAccessiblePriceView

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater?.inflate(R.layout.fragment_custom, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        regularPriceView = view.findViewById(R.id.regular_price_view)
        regularPriceView.setPrice(249)

        contentDescriptionPriceView = view.findViewById(R.id.content_description_price_view)
        contentDescriptionPriceView.setPrice(1001)

        accessiblePriceView = view.findViewById(R.id.accessible_price_view)
        accessiblePriceView.setPrice(2599)

        customActionAccessiblePriceView = view.findViewById(R.id.custom_action_accessible_price_view)
        customActionAccessiblePriceView.setPrice(4242)
    }
}
