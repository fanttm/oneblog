title: spark读写msyql
date: 2016-06-02 10:02:45
updated: 2016-06-02 10:02:47
comments:
tags:
- 
categories:
- 大数据

---

参考文档 http://alvinalexander.com/scala/scala-jdbc-connection-mysql-sql-select-example

运行以下代码，需要先导入```mysql-connector-java-5.1.39-bin.jar```包（可以从mysql官方网站下载）

```scala
package jdbc
 
import java.sql.DriverManager
import java.sql.Connection
 
/**
 * A Scala JDBC connection example by Alvin Alexander,
 * <a href="http://alvinalexander.com" title="http://alvinalexander.com">http://alvinalexander.com</a>
 */
object ScalaJdbcConnectSelect {
 
  def main(args: Array[String]) {
    // connect to the database named "mysql" on the localhost
    val driver = "com.mysql.jdbc.Driver"
    val url = "jdbc:mysql://localhost/mysql"
    val username = "root"
    val password = "mysql"
 
    // there's probably a better way to do this
    var connection:Connection = null
 
    try {
      // make the connection
      Class.forName(driver)
      connection = DriverManager.getConnection(url, username, password)
 
      // create the statement, and run the select query
      val statement = connection.createStatement()
      val resultSet = statement.executeQuery("SELECT openid, login FROM spark.users")
      while ( resultSet.next() ) {
        val openid = resultSet.getString("openid")
        val login = resultSet.getString("login")
        println("openid, login = " + openid + ", " + login)
      }
    } catch {
      case e => e.printStackTrace
    }
    connection.close()
  }
}
```
