import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.FileReader;

public class ReportingSystemGUI extends JFrame {
    
    private JLabel welcomeLabel;
    private JButton generateReportButton;

    public ReportingSystemGUI() {
        // Set up the frame
        setTitle("Automated Reporting System");
        setSize(400, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Create UI components
        welcomeLabel = new JLabel("Welcome to the Automated Reporting System");
        generateReportButton = new JButton("Generate Report");

        // Set button action
        generateReportButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    String reportData = readCobolOutputFile();
                    JOptionPane.showMessageDialog(null, reportData, "Report", JOptionPane.INFORMATION_MESSAGE);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    JOptionPane.showMessageDialog(null, "Error calling backend: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        // Layout the components
        JPanel panel = new JPanel();
        panel.add(welcomeLabel);
        panel.add(generateReportButton);

        // Add panel to frame
        add(panel);
    }

    private String readCobolOutputFile() throws Exception
    {
        StringBuilder reportData = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader("report.csv")))
        { String line;
        while((line = reader.readLine()) != null)
        {
            reportData.append(line).append("\n");
        }
    }
    return reportData.toString();
}

   
    public static void main(String[] args) {
        // Run the GUI in the Event Dispatch Thread (EDT)
        SwingUtilities.invokeLater(() -> {
            ReportingSystemGUI gui = new ReportingSystemGUI();
            gui.setVisible(true);
        });
    }
}
