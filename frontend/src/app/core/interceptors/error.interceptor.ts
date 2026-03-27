import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { AuthService } from '../services/auth.service';

export const errorInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthService);

  return next(req).pipe(
    catchError(error => {
      if (error.status === 401 || error.status === 403) {
        // Skip logout on public endpoints (login/register)
        const isAuthEndpoint = req.url.includes('/auth/');
        if (!isAuthEndpoint && authService.isAuthenticated()) {
          authService.logout();
        }
      }
      return throwError(() => error);
    })
  );
};
