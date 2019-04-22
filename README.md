# RxSQL
Rx &amp; Functional Wrapper around SQLite C  for iOS

## Create a table

```swift
 // Database Reference
 var databaseReference = DatabaseReference(path: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
  
 CreateTable("Teachers")
            .setProperty("Id", type: Int.self, canBeNull: false, isPrimaryKey: true, autoIncrement: true)
            .setProperty("Name", type: String.self, canBeNull: false)
            .setProperty("Salary", type: Float.self, canBeNull: false)
            .executable(db: databaseReference)
            .execute(db: databaseReference, SQLDone.self)
            .subscribe()
            .disposed(by: disposeBag)
```

## Inserting a record

```swift
 // Database Reference
 var databaseReference = DatabaseReference(path: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
  
 Insert(into: "Teacher")
            .properties(["Name", "Salary"])
            .executable(db: self.databaseReference)
            .bindValue(forKey: "Name", value: "John")
            .bindValue(forKey: "Salary", value: Float(485.5))
            .execute(db: self.databaseReference, SQLDone.self)
            .subscribe()
            .disposed(by: disposeBag)
```

## Querying
```swift
 // Database Reference
 var databaseReference = DatabaseReference(path: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
  
 Select("*")
            .from("Teachers")
            .innerJoin("Students")
            .on("Teachers.id == Students.TeacherId")
            .where("Teachers.salary >= 5000")
            .executable(db: self.databaseReference)
            .execute(db: self.databaseReference, SQLRow.self)
            .onSuccess: { (rows) in
                rows.forEach { print("Teacher name is \($0["Name"] as? String)") }
            })
            .disposed(by: disposeBag)
```
