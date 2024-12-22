import java.sql.*;
import java.util.Random;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicLong;

public class DatabaseThroughputTest {
    private static final int NUM_THREADS = 50;  // 线程数
    private static final int TRANSACTIONS_PER_THREAD = 500;  // 每个线程执行的事务数

    private static final Random random = new Random();
    private static AtomicLong successCount = new AtomicLong(0);  // 记录成功事务数
    private static AtomicLong failureCount = new AtomicLong(0);  // 记录失败事务数
    private static AtomicLong totalTime = new AtomicLong(0);  // 累积执行时间

    public static void main(String[] args) throws InterruptedException {
        // 初始化线程池
        ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);

        // 提交任务，模拟多线程并发执行 SELECT 查询操作
        long startTime = System.currentTimeMillis();
        for (int i = 0; i < NUM_THREADS; i++) {
            executor.submit(new DbTask());
        }

        // 关闭线程池
        executor.shutdown();
        executor.awaitTermination(Long.MAX_VALUE, TimeUnit.SECONDS);

        // 计算执行时间
        long endTime = System.currentTimeMillis();
        long elapsedTime = endTime - startTime;

        // 输出测试结果
        System.out.println("Total Time (ms): " + elapsedTime);
        System.out.println("Total Transactions: " + (NUM_THREADS * TRANSACTIONS_PER_THREAD));
        System.out.println("Total Success Count: " + successCount.get());
        System.out.println("Total Failure Count: " + failureCount.get());
        System.out.println("Total Time Taken: " + totalTime.get() + " ms");
        System.out.println("TPS (Transactions per second): " + (NUM_THREADS * TRANSACTIONS_PER_THREAD * 1000.0 / elapsedTime));
    }

    // DbTask 类，代表每个线程要执行的任务
    static class DbTask implements Runnable {
        @Override
        public void run() {
            try (Connection conn = getConnection()) {
                for (int i = 0; i < TRANSACTIONS_PER_THREAD; i++) {
                    long startTime = System.currentTimeMillis();

                    // 执行 SELECT 查询操作
                    boolean success = executeSelect(conn);

                    long endTime = System.currentTimeMillis();
                    totalTime.addAndGet(endTime - startTime);  // 累加执行时间

                    if (success) {
                        successCount.incrementAndGet();  // 成功事务计数
                    } else {
                        failureCount.incrementAndGet();  // 失败事务计数
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        private boolean executeSelect(Connection conn) throws SQLException {
            String query = "SELECT * FROM gaussdb.fact_sales_jul1 LIMIT 10";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
//                int id = random.nextInt(10000) +  400000; // 随机生成一个 ID
//                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();
                // 假设查询成功后，返回 true
                while (rs.next()) {
                    // System.out.println("id")
                }

                return true;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }

        // 获取数据库连接
        private Connection getConnection() throws SQLException {
            String DB_URL = "jdbc:postgresql://localhost:15432/postgres";
            String USER = "gaussdb";
            String PASSWORD = "@Qsh171908DDbb";

            return DriverManager.getConnection(DB_URL, USER, PASSWORD);
        }
    }
}
