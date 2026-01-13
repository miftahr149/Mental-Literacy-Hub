<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Common Head Section - Bootstrap CSS and Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<!-- Common Professional Styles -->
<style>
  :root {
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --primary-color: #667eea;
    --secondary-color: #764ba2;
    --success-color: #10b981;
    --danger-color: #ef4444;
    --warning-color: #f59e0b;
    --info-color: #3b82f6;
    --dark-color: #1f2937;
    --light-bg: #f8fafc;
    --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    --card-shadow-hover: 0 15px 40px rgba(0, 0, 0, 0.15);
  }

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    color: #1f2937;
  }

  /* Professional Cards */
  .card {
    border: none;
    border-radius: 16px;
    box-shadow: var(--card-shadow);
    transition: all 0.3s ease;
    background: white;
  }

  .card:hover {
    box-shadow: var(--card-shadow-hover);
    transform: translateY(-2px);
  }

  .card-header {
    background: var(--primary-gradient);
    color: white;
    border: none;
    border-radius: 16px 16px 0 0 !important;
    padding: 1.25rem 1.5rem;
    font-weight: 600;
  }

  .card-header h4, .card-header h5 {
    margin: 0;
    color: white;
    font-weight: 600;
  }

  /* Buttons */
  .btn {
    border-radius: 10px;
    padding: 0.625rem 1.25rem;
    font-weight: 600;
    transition: all 0.3s ease;
    border: none;
  }

  .btn-primary {
    background: var(--primary-gradient);
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
  }

  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
  }

  .btn-outline-primary {
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
    background: transparent;
  }

  .btn-outline-primary:hover {
    background: var(--primary-gradient);
    border-color: var(--primary-color);
    transform: translateY(-2px);
  }

  .btn-outline-secondary {
    border: 2px solid #e5e7eb;
    color: #6b7280;
  }

  .btn-outline-secondary:hover {
    background: #f3f4f6;
    border-color: #d1d5db;
    transform: translateY(-2px);
  }

  /* Form Controls */
  .form-control, .form-select {
    border: 2px solid #e5e7eb;
    border-radius: 10px;
    padding: 0.75rem 1rem;
    transition: all 0.3s ease;
  }

  .form-control:focus, .form-select:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    outline: none;
  }

  .form-label {
    font-weight: 600;
    color: #374151;
    margin-bottom: 0.5rem;
  }

  /* Alerts */
  .alert {
    border-radius: 12px;
    border: none;
    padding: 1rem 1.25rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .alert-danger {
    background: linear-gradient(135deg, #fee 0%, #fdd 100%);
    color: #c53030;
  }

  .alert-success {
    background: linear-gradient(135deg, #f0fff4 0%, #e6ffed 100%);
    color: #22543d;
  }

  .alert-info {
    background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
    color: #1e40af;
  }

  /* Navbar Enhancement */
  .navbar {
    background: white !important;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 1rem 0;
  }

  .navbar-brand {
    font-weight: 700;
    font-size: 1.5rem;
    background: var(--primary-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .nav-link {
    color: #6b7280 !important;
    font-weight: 500;
    padding: 0.5rem 1rem !important;
    border-radius: 8px;
    transition: all 0.3s ease;
    margin: 0 0.25rem;
  }

  .nav-link:hover, .nav-link.active {
    color: var(--primary-color) !important;
    background: rgba(102, 126, 234, 0.1);
  }

  /* Badges */
  .badge {
    padding: 0.5rem 0.75rem;
    border-radius: 8px;
    font-weight: 600;
  }

  .badge.bg-primary {
    background: var(--primary-gradient) !important;
  }

  /* Container Padding */
  .container {
    padding-top: 2rem;
    padding-bottom: 2rem;
  }

  /* Statistics Cards */
  .stat-card {
    background: white;
    border-radius: 16px;
    padding: 1.5rem;
    box-shadow: var(--card-shadow);
    transition: all 0.3s ease;
    border-left: 4px solid var(--primary-color);
  }

  .stat-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--card-shadow-hover);
  }

  .stat-card .stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.75rem;
    margin-bottom: 1rem;
    background: var(--primary-gradient);
    color: white;
  }

  .stat-card .stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: #1f2937;
    margin: 0.5rem 0;
  }

  .stat-card .stat-label {
    color: #6b7280;
    font-size: 0.9rem;
    font-weight: 500;
  }

  /* Page Headers */
  .page-header {
    margin-bottom: 2rem;
  }

  .page-header h2 {
    font-size: 2rem;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 0.5rem;
  }

  .page-header p {
    color: #6b7280;
    font-size: 1rem;
  }

  /* Animations */
  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .fade-in {
    animation: fadeIn 0.6s ease-out;
  }

  /* Profile Picture Styles */
  .profile-picture {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    border: 4px solid var(--primary-color);
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
  }

  /* Table Styles */
  .table {
    border-radius: 12px;
    overflow: hidden;
  }

  .table thead {
    background: var(--primary-gradient);
    color: white;
  }

  .table thead th {
    border: none;
    font-weight: 600;
    padding: 1rem;
  }

  .table tbody tr {
    transition: background 0.2s ease;
  }

  .table tbody tr:hover {
    background: #f9fafb;
  }

  /* Responsive */
  @media (max-width: 768px) {
    .card {
      margin-bottom: 1rem;
    }
    
    .page-header h2 {
      font-size: 1.5rem;
    }
  }
</style>
