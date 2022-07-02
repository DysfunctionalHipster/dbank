import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// -!- Cannister 1 -!-

actor DBank { 

  stable var currentValue: Float = 300;
  stable var startTime = Time.now();

  public func topUp(amount: Float) {
    currentValue += amount;
    // Debug.print(debug_show(currentValue));
  }; // -this- Adds user amount to balance

  public func withdraw(amount: Float) {
    let balance: Float = currentValue - amount;
    if (balance >= 0) {
      currentValue -= amount;
      // Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Not enough money buddy")
    }
  }; // -this- Removes user amount from balance

  public query func checkBalance(): async Float {
    return currentValue;
  }; // -this- Checks balance

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNaSecs = currentTime - startTime;
    let timeElapsedMinutes = timeElapsedNaSecs / 60000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedMinutes));
    startTime := currentTime;
  }; // -this- Compounds the interest of the balance
}