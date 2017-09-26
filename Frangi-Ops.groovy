#@OpService op
#@UIService ui
#@Img input
#@String(label="scales: e.g. \"1, 2, 3\"",value="5") scale
#@String(label="spacing: e.g. \"1, 1, 1\"",value="1, 1") spacing
//scales refers the the pixel distance at which the filter operates. Larger scales measure larger structures.
//spacing refers to the physical distance between pixels. The default setting is {1, 1, 1...}
import java.util.Arrays
import net.imglib2.img.Img
import net.imglib2.img.array.ArrayImgs
import net.imglib2.type.numeric.real.DoubleType
import net.imglib2.type.numeric.integer.IntType
import net.imagej.ops.filter.vesselness.DefaultFrangi
//parse the strings

double[] scales = Arrays.stream(scale.split(",")).map{
	t -> Double.parseDouble(t.trim())
}.collect() as double[]
double[] spacings = Arrays.stream(spacing.split(",")).map{
	t -> Double.parseDouble(t.trim())
}.collect() as double[]
long[] dims = new long[input.numDimensions()]
input.dimensions(dims)
actualOutput = ArrayImgs.doubles(dims)
op.run(DefaultFrangi.class, actualOutput, input, spacings, scales)
ui.show("result", actualOutput)