using Microsoft.Extensions.Primitives;

public static class RegistryNumberHelper
{
  private static Random rnd = new Random();
  private static string suffixes = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  private static int MIN_RANDOM_NUMBER_LENGTH = 3;
  private static int MAX_RANDOM_NUMBER_LENGTH = 5;
  private static double PROPABILITY_TO_GENERATE_SUFFIX = .3; // 30% of all generated registry numbers will receive a letter suffix
  private static double PROPABILITY_TO_RETURN_SUFFIX = .25; // Start with 25% propability to return the current letter

  public static string generateSuffix()
  {
    float r = rnd.NextSingle();
    int i = 0;
    int steps = suffixes.Length - 1;
    bool x = false;

    if (r < PROPABILITY_TO_GENERATE_SUFFIX)
    {
      do
      {
        r = rnd.NextSingle();
        x = r < PROPABILITY_TO_RETURN_SUFFIX + (i * (1 - PROPABILITY_TO_RETURN_SUFFIX) / steps);
        if (x)
        {
          return $"-{suffixes[i]}";
        }
        i++;
      } while (!x);
    }

    return string.Empty;
  }

  /// <summary>
  /// When the length parameter is specified, try to use it. Otherwise generate
  /// a random length between MIN or MAX length.
  /// </summary>
  /// <param name="length"></param>
  /// <returns></returns>
  public static string generateNumber(StringValues length)
  {
    if (length == string.Empty || !Int32.TryParse(length, out int len))
    {
      // Length of registry number is between 3 or 5 characters
      len = rnd.Next(MIN_RANDOM_NUMBER_LENGTH, MAX_RANDOM_NUMBER_LENGTH);
    }
    return rnd.Next().ToString().Substring(0, len);
  }
}