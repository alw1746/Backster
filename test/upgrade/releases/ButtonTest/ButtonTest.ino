#include <Button.h>
#include <LiquidCrystal.h>
#define ledflash 17

LiquidCrystal lcd(8, 7, 6, 5, 4, 16);
ButtonCB sbutton(18, Button::INTERNAL_PULLUP, 30);
ButtonCB fbutton(11, Button::INTERNAL_PULLUP, 30);
ButtonCB lbutton(2, Button::INTERNAL_PULLUP, 30);
ButtonCB rbutton(3, Button::INTERNAL_PULLUP, 30);

void setup() {
  pinMode(ledflash, OUTPUT);      //builtin LED
  digitalWrite(ledflash, LOW);
  lcd.begin(16, 2);
  lcd.clear();

  sbutton.setPressHandler(onPressHoldSB);
  sbutton.setHoldHandler(onPressHoldSB);
  sbutton.setHoldRepeats(true);
  sbutton.setHoldThreshold(100);
  
  fbutton.setPressHandler(onPressHoldFB);
  fbutton.setHoldHandler(onPressHoldFB);
  fbutton.setHoldRepeats(true);
  fbutton.setHoldThreshold(100);

  lbutton.setPressHandler(onPressHoldLB);
  lbutton.setHoldHandler(onPressHoldLB);
  lbutton.setHoldRepeats(true);
  lbutton.setHoldThreshold(150);

  rbutton.setPressHandler(onPressHoldRB);
  rbutton.setHoldHandler(onPressHoldRB);
  rbutton.setHoldRepeats(true);
  rbutton.setHoldThreshold(150);

}

void onPressHoldSB(const Button&) {
  lcd.clear();
  lcd.print("Select button");
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
  delay(1000);
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
}

void onPressHoldFB(const Button&) {
  lcd.clear();
  lcd.print("Fire button");
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
  delay(1000);
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
}

void onPressHoldLB(const Button&) {
  lcd.clear();
  lcd.print("Left button");
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
  delay(1000);
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
}

void onPressHoldRB(const Button&) {
  lcd.clear();
  lcd.print("Right button");
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
  delay(1000);
  digitalWrite(ledflash, !digitalRead(ledflash));   //might as well toggle LED on/off.
}

void loop() {
    lbutton.process();
    rbutton.process();
    fbutton.process();
    sbutton.process();
}



