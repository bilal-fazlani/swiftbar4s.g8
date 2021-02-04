val org = "$org$"

inThisBuild(
  Seq(
    scalaVersion := "$scalaVersion$",
    organization := org,
    version := "$version$",
    resolvers += Resolver.JCenterRepository,
    testFrameworks += TestFramework("munit.Framework")
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