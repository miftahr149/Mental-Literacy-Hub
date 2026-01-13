<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Profile</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="profile"/>
  </jsp:include>

  <div class="container py-5 fade-in">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div class="card">
          <div class="card-header">
            <h4 class="mb-0"><i class="bi bi-pencil-square me-2"></i> Edit Profile</h4>
          </div>
          <div class="card-body p-4">
            <c:if test="${not empty error}">
              <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle"></i> ${error}
              </div>
            </c:if>
            <c:if test="${not empty success}">
              <div class="alert alert-success" role="alert">
                <i class="bi bi-check-circle"></i> ${success}
              </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/user-management/profile/edit" enctype="multipart/form-data">
              <div class="mb-4 text-center">
                <label class="form-label d-block mb-3">Profile Picture</label>
                <div class="position-relative d-inline-block">
                  <c:choose>
                    <c:when test="${user.profilePicture != null && !user.profilePicture.isEmpty()}">
                      <img id="profilePreview" 
                           src="${pageContext.request.contextPath}/uploads/profile-pictures/${user.profilePicture}" 
                           alt="Profile Picture" 
                           class="profile-picture"
                           style="cursor: pointer;"
                           onclick="document.getElementById('profilePicture').click()">
                    </c:when>
                    <c:otherwise>
                      <div id="profilePreview" 
                           class="profile-picture d-inline-flex align-items-center justify-content-center bg-light border-4"
                           style="border-color: #667eea; cursor: pointer;"
                           onclick="document.getElementById('profilePicture').click()">
                        <i class="bi bi-person-circle" style="font-size: 5rem; color: #9ca3af;"></i>
                      </div>
                    </c:otherwise>
                  </c:choose>
                  <div class="position-absolute bottom-0 end-0 rounded-circle p-2 shadow" 
                       style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); cursor: pointer; border: 3px solid white;"
                       onclick="document.getElementById('profilePicture').click()">
                    <i class="bi bi-camera-fill text-white"></i>
                  </div>
                </div>
                <input type="file" 
                       id="profilePicture" 
                       name="profilePicture" 
                       accept="image/*" 
                       class="d-none"
                       onchange="previewImage(this)">
                <small class="text-muted d-block mt-3">Click the image to change your profile picture</small>
              </div>

              <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text"
                       name="name"
                       class="form-control"
                       placeholder="Enter your full name"
                       value="${user.name}"
                       required>
              </div>

              <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="you@example.com"
                       value="${user.email}"
                       required>
              </div>

              <div class="mb-3">
                <label class="form-label">Role</label>
                <input type="text"
                       class="form-control bg-light"
                       value="${user.role}"
                       disabled>
                <small class="text-muted">Role cannot be changed</small>
              </div>

              <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-primary">
                  <i class="bi bi-check-circle"></i> Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/user-management/profile" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-left"></i> Cancel
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function previewImage(input) {
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
          const preview = document.getElementById('profilePreview');
          if (preview.tagName === 'IMG') {
            preview.src = e.target.result;
          } else {
            // Replace div with img
            const img = document.createElement('img');
            img.id = 'profilePreview';
            img.src = e.target.result;
            img.alt = 'Profile Picture';
            img.className = 'rounded-circle border border-3 border-primary';
            img.className = 'profile-picture';
            img.style.cssText = 'cursor: pointer;';
            img.onclick = function() { document.getElementById('profilePicture').click(); };
            preview.parentNode.replaceChild(img, preview);
          }
        };
        reader.readAsDataURL(input.files[0]);
      }
    }
  </script>
</body>
</html>

