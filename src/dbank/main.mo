import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;

  stable var startTime = Time.now();

  public func topUp(amount: Float) {
    currentValue += amount;
    // Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let balance: Float = currentValue - amount;
    if (balance >= 0) {
      currentValue -= amount;
      // Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Not enough money buddy")
    }
  };

  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNaSecs = currentTime - startTime;
    let timeElapsedMinutes = timeElapsedNaSecs / 60000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedMinutes));
    startTime := currentTime;
  }
}