namespace Application.UnitTests;

public class Application_Specification
{
    [Fact]
    public void This_is_a_passing_test() => true.Should().BeTrue();

    [Fact]
    public void This_is_another_passing_test() => true.Should().BeTrue();

    // The docker pipeline exits on first test failure
    // Is there a way to run all tests and get all failures reported on
    // similar to how ncrunch might do it or a ci pipeline
    // Todo: research test runner settings
    [Fact(Skip = "This is to test failing output in a docker pipeline")]
    public void This_is_a_failing_test() => false.Should().BeTrue();
}