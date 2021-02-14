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

lazy val root = (project in file("."))
  .enablePlugins(NativeImagePlugin)
  .settings(
    name := "$name;format="camel"$",
    //GRAAL NATIVE IMAGE
    nativeImageOptions ++= List("--initialize-at-build-time", "--no-fallback"),
    // nativeImageInstalled := true,
    nativeImageJvm := "graalvm-java11",
    nativeImageVersion := "21.0.0",
    nativeImageOutput := file(name.value),
    nativeImageAgentMerge := true,
    nativeImageAgentOutputDir := baseDirectory.value / "src" / "main" / "resources"/ "META-INF"/"native-image",
    //GRAAL NATIVE IMAGE
    libraryDependencies ++= Seq(
      Libs.swiftbar4s,
      Libs.munit % Test
    )
  )