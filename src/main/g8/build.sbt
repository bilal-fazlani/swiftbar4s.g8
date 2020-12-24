val org = "$org$"

inThisBuild(
  Seq(
    scalaVersion := "$scalaVersion$",
    organization := org,
    testFrameworks += TestFramework("munit.Framework"),
    resolvers += "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots"
  )
)

lazy val root = (project in file(".")).
  settings(
    name := "$name;format="camel"$",
    libraryDependencies ++= Seq(
      Libs.swiftbar4s,
      Libs.munit % Test
    )
  )