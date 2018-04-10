package ca.on.oicr.pde.workflows;

import ca.on.oicr.pde.utilities.workflows.OicrWorkflow;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import net.sourceforge.seqware.pipeline.workflowV2.model.Job;
import net.sourceforge.seqware.pipeline.workflowV2.model.SqwFile;

public class WorkflowClient extends OicrWorkflow {

    //workflow parameters
    private String bamfile = null;
    private String bedfile = null;
    //workflow directories
    private String dataDir = null;
    private Boolean manualOutput = false;
    
    
    //Constructor - called in setupDirectory()
    private void WorkflowClient() {

        
        
        dataDir = "data/";
        bamfile = getProperty("bamfile");
        manualOutput = Boolean.valueOf(getProperty("manual_output"));
        bedfile = getProperty("bedfile");

    }

    @Override
    public void setupDirectory() {
        WorkflowClient(); //Constructor call
        addDirectory(dataDir);
    }

    @Override
    public Map<String, SqwFile> setupFiles() {
        SqwFile file0 = this.createFile("file_in_0");
        file0.setSourcePath(bamfile);
        file0.setType("application/bam");
        file0.setIsInput(true);

        return this.getFiles();
    }

    @Override
    public void buildWorkflow() {
        String flagstatFile=dataDir+"flagstat.json";
        
        Job job0 = getFlagstatJob(bamfile, flagstatFile);
        Job job1 = getBamQcJob(flagstatFile);
        job1.addParent(job0);
    }

    private Job getFlagstatJob(String inputFile, String outputFile) {
        Job job = getWorkflow().createBashJob("Flagstat");

        List<String> c = new LinkedList<>();
        c.add(getProperty("samtools"));
        c.add("flagstat");
        c.add(inputFile);
        c.add("|");
        c.add(getProperty("flagstat2json"));
        c.add(">");
        c.add(outputFile);

        job.getCommand().setArguments(c);

        return job;
    }

    private Job getBamQcJob(String flagstatFile) {
        Job job = getWorkflow().createBashJob("BamQC");

        String jsonOutFile = bamfile.substring(bamfile.lastIndexOf("/") + 1) + ".BamQC.json";

        List<String> c = new LinkedList<>();
        c.add(getProperty("samtools"));
        c.add("view");
        c.add(bamfile);
        c.add("|");
        c.add("perl " + getProperty("bamqc_pl"));
        c.add("-r " + bedfile);
        c.add("-j " + flagstatFile);
        c.add(">");
        c.add(dataDir + jsonOutFile);
        
        job.getCommand().setArguments(c);
        
        SqwFile sqwOut = createOutputFile(dataDir + jsonOutFile, "text/json", manualOutput);
        job.addFile(sqwOut);
        
        return job;
    }

}
