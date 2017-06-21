package menegatti.accessibility101.view.price

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageButton
import android.widget.RelativeLayout
import android.widget.TextView
import menegatti.accessibility101.R

class ContentDescriptionPriceView @JvmOverloads constructor(context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0) : RelativeLayout(context, attrs, defStyleAttr) {

    private val priceContainer: View
    private val amount:  TextView
    private val cents: TextView

    private val buttonContainer: View
    private val incrementButton: ImageButton
    private val decrementButton: ImageButton

    private var price = 0

    init {
        LayoutInflater.from(context).inflate(R.layout.view_price, this, true)

        priceContainer = findViewById(R.id.price_container)
        amount = findViewById(R.id.priceview_amount)
        cents = findViewById(R.id.priceview_cents)

        buttonContainer = findViewById(R.id.button_container)
        incrementButton = findViewById(R.id.add_one)
        decrementButton = findViewById(R.id.remove_one)

        priceContainer.setOnClickListener { toggleButtonContainerVisibility() }
        incrementButton.setOnClickListener { incrementPrice() }
        decrementButton.setOnClickListener { decrementPrice() }
    }

    private fun toggleButtonContainerVisibility() {
        buttonContainer.visibility = if (buttonContainer.visibility == android.view.View.GONE) {
            android.view.View.VISIBLE
        } else {
            android.view.View.GONE
        }
    }

    private fun incrementPrice() {
        setPrice(price + 10)
    }

    private fun decrementPrice() {
        setPrice(price - 10)
    }

    fun setPrice(price: Int) {
        this.price = price
        amount.text = String.format("%d", price / 100)
        cents.text = String.format("%02d", price % 100)
        priceContainer.contentDescription = getEurosText() + getCentsText()
    }

    private fun getEurosText(): String {
        return if (price / 100 > 1) {
            (price / 100).toString() + " euros "
        } else if (price / 100 == 1) {
            " one euro "
        } else {
            ""
        }
    }

    private fun getCentsText(): String {
        return if (price % 100 > 0) {
            (price % 100).toString() + " cents "
        } else {
            ""
        }
    }
}