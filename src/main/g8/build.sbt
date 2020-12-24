val scalaVersion = "$scalaVersion$"
val org = "$org$"

inThisBuild(
  Seq(
    scalaVersion := scalaVersion,
    organization := org,
    testFrameworks += TestFramework("munit.Framework")
  )
)

lazy val root = (project in file(".")).
  settings(
    name := "$pluginName$",
    libraryDependencies ++= Seq(
      Libs.munit % Test
    )
  )