import javax.swing.UIManager;
 
$systemLaf = [UIManager getSystemLookAndFeelClassName];
@lafInfos = [UIManager getInstalledLookAndFeels];
$lengthOfLongestName = 0;
$lengthOfLongestClass = 0;

foreach $info (@lafInfos) {
    $class = [$info getClassName];
    $name = [$info getName];
    %lafs[$name] = $class;
    $length = strlen($name);
    if ($length > $lengthOfLongestName) {
        $lengthOfLongestName = $length;
    }
    $classLength = strlen($class);
    if ($classLength > $lengthOfLongestClass) {
        $lengthOfLongestClass = $classLength;
    }
}
 
$lineFormat = "%-$lengthOfLongestName" . "s %-$lengthOfLongestClass" . "s %s";
foreach $name => $class (%lafs) {
    [[System out] printf: $lineFormat, @($name, $class)];
    if ($class eq $systemLaf) {
        println(" SystemLookAndFeel");
    }
    else {
        println('');
    }
}

