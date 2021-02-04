package $package$

import com.bilalfazlani.swiftbar4s._
import com.bilalfazlani.swiftbar4s.dsl.HandlerDsl
import com.bilalfazlani.swiftbar4s.dsl.MenuDsl

object Main extends Plugin with MenuDsl with HandlerDsl {
  
  override val handler = handler {
    handle("send-email") { emailMayBe =>
      emailMayBe.map(sendEmail)
    }

    handle("print-hello") {
      println("hello world")
    }
  }

  override val appMenu = menu("$name$",textSize = 20) {
    action("send email", "send-email", Some("abc@xyz.com"), true)
    action("print hello", "print-hello", showTerminal = true)
    text("item 1", font = "Times")
    ---
    text("item 2", textSize = 15)
    subMenu("submenu") {
      text("item 3")
      text("item 4")
      subMenu("nested", color = "orange") {
        text("item 5")
        ---
        text("item 6")
        shellCommand(
          "item 7",
          "echo",
          showTerminal = true,
          params = "hello world",
          "sds"
        )
      }
    }
  }

  def sendEmail(email: String) = println(s"email sent to \$email")
}
