<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Analytics & Reports</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <jsp:include page="/component/common_head.jsp"/>
  </head>
  <body class="bg-light">
    <jsp:include page="/component/main_navbar.jsp">
      <jsp:param name="activePage" value="analytics"/>
    </jsp:include>
    <div class="container py-5">
      <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
          <h2 class="fw-bold">Analytics & Reports</h2>
          <p class="text-muted">Overview of user engagement, resource usage, and feedback reports</p>
        </div>
      </div>

      <!-- cards -->
      <div class="row g-4 mb-5">
        <div class="col-md-4">
          <div class="card shadow-sm text-center p-3">
            <h5 class="card-title">Users Engaged</h5>
            <p class="display-6 fw-bold">120</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card shadow-sm text-center p-3">
            <h5 class="card-title">Resources Used</h5>
            <p class="display-6 fw-bold">85</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card shadow-sm text-center p-3">
            <h5 class="card-title">Feedback Received</h5>
            <p class="display-6 fw-bold">42</p>
          </div>
        </div>
      </div>

      <!-- buttons -->
      <div class="card mb-5 shadow-sm p-3">
        <h5 class="card-title fw-bold mb-3">Generate Reports</h5>
        <p class="text-muted mb-3">Click a report to view details</p>
        <div class="d-flex gap-2 flex-wrap">
          <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userEngagementModal">
            User Engagement Report
          </button>
          <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#resourceUsageModal">
            Resource Usage Report
          </button>
          <button class="btn btn-info text-white" data-bs-toggle="modal" data-bs-target="#feedbackSummaryModal">
            Feedback Summary
          </button>
        </div>
      </div>

      <!-- filter (not working yet) -->
      <div class="card shadow-sm p-3">
        <h5 class="card-title fw-bold mb-3">Filter Reports</h5>
        <form class="row g-2 align-items-center">
          <div class="col-auto">
            <input type="date" class="form-control" placeholder="Start Date">
          </div>
          <div class="col-auto">
            <input type="date" class="form-control" placeholder="End Date">
          </div>
          <div class="col-auto">
            <select class="form-select">
              <option value="">Select Category</option>
              <option value="engagement">User Engagement</option>
              <option value="resources">Resource Usage</option>
              <option value="feedback">Feedback Summary</option>
            </select>
          </div>
          <div class="col-auto">
            <button type="submit" class="btn btn-primary">Filter</button>
          </div>
          <div class="col-auto">
            <button type="button" class="btn btn-success">Export</button>
          </div>
        </form>
      </div>
    </div>

    <!-- engagement modal -->
    <div class="modal fade" id="userEngagementModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title">User Engagement Report</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <canvas id="userEngagementChart" height="300"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-success">Export Report</button>
          </div>
        </div>
      </div>
    </div>

    <!-- usage modal -->
    <div class="modal fade" id="resourceUsageModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-success text-white">
            <h5 class="modal-title">Resource Usage Report</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <canvas id="resourceUsageChart" height="300"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-success">Export Report</button>
          </div>
        </div>
      </div>
    </div>

    <!-- summary modal -->
    <div class="modal fade" id="feedbackSummaryModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-info text-white">
            <h5 class="modal-title">Feedback Summary Report</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <canvas id="feedbackSummaryChart" height="300"></canvas>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-success">Export Report</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      
    // engagement chart
      new Chart(document.getElementById('userEngagementChart'), {
        type: 'line',
        data: {
          labels: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'],
          datasets: [{
            label: 'Active Users',
            data: [50, 65, 80, 70, 90, 100, 120],
            borderColor: 'rgba(54, 162, 235, 1)',
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            tension: 0.3
          }]
        }
      });

      // usage chart
      new Chart(document.getElementById('resourceUsageChart'), {
        type: 'bar',
        data: {
          labels: ['Resource A', 'Resource B', 'Resource C', 'Resource D'],
          datasets: [{
            label: 'Usage Count',
            data: [20, 35, 25, 40],
            backgroundColor: 'rgba(75, 192, 192, 0.7)'
          }]
        }
      });

      // feedback chart
      new Chart(document.getElementById('feedbackSummaryChart'), {
        type: 'doughnut',
        data: {
          labels: ['Positive', 'Neutral', 'Negative'],
          datasets: [{
            label: 'Feedback Count',
            data: [30, 10, 5],
            backgroundColor: [
              'rgba(54, 162, 235, 0.7)',
              'rgba(201, 203, 207, 0.7)',
              'rgba(255, 99, 132, 0.7)'
            ]
          }]
        }
      });
    </script>
  </body>
</html>
