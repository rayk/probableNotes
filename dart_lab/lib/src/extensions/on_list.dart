
/// Extensions for [int] type.
extension OnList on List {
  
  /// Returns True when each item in this list is unique;
  bool get isEachUnique => this.toSet().length == this.length;
  
  
  /// Returns True when every item in this list is present in [other].
  bool containsEveryMemberIn(List other) => 
      this.every((item) => other.contains(item));
}