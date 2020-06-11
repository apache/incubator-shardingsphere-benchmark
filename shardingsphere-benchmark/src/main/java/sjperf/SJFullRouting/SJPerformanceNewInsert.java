package sjperf.SJFullRouting;

import org.apache.jmeter.protocol.java.sampler.AbstractJavaSamplerClient;
import org.apache.jmeter.protocol.java.sampler.JavaSamplerContext;
import org.apache.jmeter.samplers.SampleResult;
import service.api.service.SJPerfService;
import service.util.config.sjperf.SJPerfDataSourceUtil;
import service.util.config.sjperf.SJPerfDataSourceOp;
import sjperf.v3.SQLStatement;

import javax.sql.DataSource;
import java.sql.SQLException;

/**
 * sharding jdbc performance for insert
 */
public class SJPerformanceNewInsert extends AbstractJavaSamplerClient {
    public static final String INSERT_SQL_MASTER_SLAVE = SQLStatement.INSERT_SQL_SHARDING.getValue();
    public static SJPerfService sjPerfService;
    private  DataSource dataSource;

    static {
        try {
            sjPerfService = new SJPerfService(SJPerfDataSourceOp.CreateShardingNewDataSource());
            //sjPerfService = new SJPerfService(SJPerfDataSourceOp.CreateShardingDataSource());
        } catch (final SQLException ex) {
            //throw new SQLException(ex);
        }
    }
    @Override
    public void setupTest(JavaSamplerContext context) {
        dataSource=sjPerfService.dataSource;
    }
    @Override
    public SampleResult runTest(JavaSamplerContext javaSamplerContext) {

        SampleResult results = new SampleResult();
        results.setSampleLabel("SJPerformanceInsert");
        results.sampleStart();
        try {
            SJPerfDataSourceUtil.insert(INSERT_SQL_MASTER_SLAVE,dataSource);
        } catch (SQLException ex) {
            results.setSuccessful(false);
            return results;
        } finally {
            results.sampleEnd();
        }
        results.setSuccessful(true);
        return results;
    }
    

}
