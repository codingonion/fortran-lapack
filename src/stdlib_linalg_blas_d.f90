module stdlib_linalg_blas_d
     use stdlib_linalg_constants
     use stdlib_linalg_blas_aux
     use stdlib_linalg_blas_s
     implicit none(type,external)
     private






     public :: sp,dp,lk,int32,int64
     public :: stdlib_dasum
     public :: stdlib_daxpy
     public :: stdlib_dcopy
     public :: stdlib_ddot
     public :: stdlib_dgbmv
     public :: stdlib_dgemm
     public :: stdlib_dgemv
     public :: stdlib_dger
     public :: stdlib_dnrm2
     public :: stdlib_drot
     public :: stdlib_drotg
     public :: stdlib_drotm
     public :: stdlib_drotmg
     public :: stdlib_dsbmv
     public :: stdlib_dscal
     public :: stdlib_dsdot
     public :: stdlib_dspmv
     public :: stdlib_dspr
     public :: stdlib_dspr2
     public :: stdlib_dswap
     public :: stdlib_dsymm
     public :: stdlib_dsymv
     public :: stdlib_dsyr
     public :: stdlib_dsyr2
     public :: stdlib_dsyr2k
     public :: stdlib_dsyrk
     public :: stdlib_dtbmv
     public :: stdlib_dtbsv
     public :: stdlib_dtpmv
     public :: stdlib_dtpsv
     public :: stdlib_dtrmm
     public :: stdlib_dtrmv
     public :: stdlib_dtrsm
     public :: stdlib_dtrsv
     public :: stdlib_dzasum
     public :: stdlib_dznrm2


     contains
     
     
     real(dp) function stdlib_dasum(n,dx,incx)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) dtemp
           integer(int32) i,m,mp1,nincx
           ! ..
           ! .. intrinsic functions ..
           intrinsic dabs,mod
           ! ..
           stdlib_dasum = 0.0d0
           dtemp = 0.0d0
           if (n<=0 .or. incx<=0) return
           if (incx==1) then
              ! code for increment equal to 1
     
     
              ! clean-up loop
     
              m = mod(n,6)
              if (m/=0) then
                 do i = 1,m
                    dtemp = dtemp + dabs(dx(i))
                 end do
                 if (n<6) then
                    stdlib_dasum = dtemp
                    return
                 end if
              end if
              mp1 = m + 1
              do i = mp1,n,6
                 dtemp = dtemp + dabs(dx(i)) + dabs(dx(i+1)) +dabs(dx(i+2)) + dabs(dx(i+3)) +dabs(&
                           dx(i+4)) + dabs(dx(i+5))
              end do
           else
     
              ! code for increment not equal to 1
     
              nincx = n*incx
              do i = 1,nincx,incx
                 dtemp = dtemp + dabs(dx(i))
              end do
           end if
           stdlib_dasum = dtemp
           return
     
           ! end of stdlib_dasum
     
     end function stdlib_dasum
     
     
     subroutine stdlib_daxpy(n,da,dx,incx,dy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) da
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*),dy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,ix,iy,m,mp1
           ! ..
           ! .. intrinsic functions ..
           intrinsic mod
           ! ..
           if (n<=0) return
           if (da==0.0d0) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
     
              ! clean-up loop
     
              m = mod(n,4)
              if (m/=0) then
                 do i = 1,m
                    dy(i) = dy(i) + da*dx(i)
                 end do
              end if
              if (n<4) return
              mp1 = m + 1
              do i = mp1,n,4
                 dy(i) = dy(i) + da*dx(i)
                 dy(i+1) = dy(i+1) + da*dx(i+1)
                 dy(i+2) = dy(i+2) + da*dx(i+2)
                 dy(i+3) = dy(i+3) + da*dx(i+3)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
               dy(iy) = dy(iy) + da*dx(ix)
               ix = ix + incx
               iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_daxpy
     
     end subroutine stdlib_daxpy
     
     
     subroutine stdlib_dcopy(n,dx,incx,dy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*),dy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,ix,iy,m,mp1
           ! ..
           ! .. intrinsic functions ..
           intrinsic mod
           ! ..
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
     
              ! clean-up loop
     
              m = mod(n,7)
              if (m/=0) then
                 do i = 1,m
                    dy(i) = dx(i)
                 end do
                 if (n<7) return
              end if
              mp1 = m + 1
              do i = mp1,n,7
                 dy(i) = dx(i)
                 dy(i+1) = dx(i+1)
                 dy(i+2) = dx(i+2)
                 dy(i+3) = dx(i+3)
                 dy(i+4) = dx(i+4)
                 dy(i+5) = dx(i+5)
                 dy(i+6) = dx(i+6)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 dy(iy) = dx(ix)
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_dcopy
     
     end subroutine stdlib_dcopy
     
     
     real(dp) function stdlib_ddot(n,dx,incx,dy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*),dy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) dtemp
           integer(int32) i,ix,iy,m,mp1
           ! ..
           ! .. intrinsic functions ..
           intrinsic mod
           ! ..
           stdlib_ddot = 0.0d0
           dtemp = 0.0d0
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
              ! code for both increments equal to 1
     
     
              ! clean-up loop
     
              m = mod(n,5)
              if (m/=0) then
                 do i = 1,m
                    dtemp = dtemp + dx(i)*dy(i)
                 end do
                 if (n<5) then
                    stdlib_ddot=dtemp
                 return
                 end if
              end if
              mp1 = m + 1
              do i = mp1,n,5
               dtemp = dtemp + dx(i)*dy(i) + dx(i+1)*dy(i+1) +dx(i+2)*dy(i+2) + dx(i+3)*dy(i+3) + &
                         dx(i+4)*dy(i+4)
              end do
           else
     
              ! code for unequal increments or equal increments
                ! not equal to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 dtemp = dtemp + dx(ix)*dy(iy)
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           stdlib_ddot = dtemp
           return
     
           ! end of stdlib_ddot
     
     end function stdlib_ddot
     
     
     subroutine stdlib_dgbmv(trans,m,n,kl,ku,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) incx,incy,kl,ku,lda,m,n
           character trans
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,iy,j,jx,jy,k,kup1,kx,ky,lenx,leny
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 1
           else if (m<0) then
               info = 2
           else if (n<0) then
               info = 3
           else if (kl<0) then
               info = 4
           else if (ku<0) then
               info = 5
           else if (lda< (kl+ku+1)) then
               info = 8
           else if (incx==0) then
               info = 10
           else if (incy==0) then
               info = 13
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dgbmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           ! set  lenx  and  leny, the lengths of the vectors x and y, and set
           ! up the start points in  x  and  y.
     
           if (stdlib_lsame(trans,'n')) then
               lenx = n
               leny = m
           else
               lenx = m
               leny = n
           end if
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (lenx-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (leny-1)*incy
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the band part of a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,leny
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,leny
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,leny
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,leny
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           kup1 = ku + 1
           if (stdlib_lsame(trans,'n')) then
     
              ! form  y := alpha*a*x + y.
     
               jx = kx
               if (incy==1) then
                   do 60 j = 1,n
                       temp = alpha*x(jx)
                       k = kup1 - j
                       do 50 i = max(1,j-ku),min(m,j+kl)
                           y(i) = y(i) + temp*a(k+i,j)
        50             continue
                       jx = jx + incx
        60         continue
               else
                   do 80 j = 1,n
                       temp = alpha*x(jx)
                       iy = ky
                       k = kup1 - j
                       do 70 i = max(1,j-ku),min(m,j+kl)
                           y(iy) = y(iy) + temp*a(k+i,j)
                           iy = iy + incy
        70             continue
                       jx = jx + incx
                       if (j>ku) ky = ky + incy
        80         continue
               end if
           else
     
              ! form  y := alpha*a**t*x + y.
     
               jy = ky
               if (incx==1) then
                   do 100 j = 1,n
                       temp = zero
                       k = kup1 - j
                       do 90 i = max(1,j-ku),min(m,j+kl)
                           temp = temp + a(k+i,j)*x(i)
        90             continue
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
       100         continue
               else
                   do 120 j = 1,n
                       temp = zero
                       ix = kx
                       k = kup1 - j
                       do 110 i = max(1,j-ku),min(m,j+kl)
                           temp = temp + a(k+i,j)*x(ix)
                           ix = ix + incx
       110             continue
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
                       if (j>ku) kx = kx + incx
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dgbmv
     
     end subroutine stdlib_dgbmv
     
     
     subroutine stdlib_dgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) k,lda,ldb,ldc,m,n
           character transa,transb
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,j,l,nrowa,nrowb
           logical(lk) nota,notb
           ! ..
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
     
           ! set  nota  and  notb  as  true if  a  and  b  respectively are not
           ! transposed and set  nrowa and nrowb  as the number of rows of  a
           ! and  b  respectively.
     
           nota = stdlib_lsame(transa,'n')
           notb = stdlib_lsame(transb,'n')
           if (nota) then
               nrowa = m
           else
               nrowa = k
           end if
           if (notb) then
               nrowb = k
           else
               nrowb = n
           end if
     
           ! test the input parameters.
     
           info = 0
           if ((.not.nota) .and. (.not.stdlib_lsame(transa,'c')) .and.(.not.stdlib_lsame(transa,&
                     't'))) then
               info = 1
           else if ((.not.notb) .and. (.not.stdlib_lsame(transb,'c')) .and.(.not.stdlib_lsame(&
                     transb,'t'))) then
               info = 2
           else if (m<0) then
               info = 3
           else if (n<0) then
               info = 4
           else if (k<0) then
               info = 5
           else if (lda<max(1,nrowa)) then
               info = 8
           else if (ldb<max(1,nrowb)) then
               info = 10
           else if (ldc<max(1,m)) then
               info = 13
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dgemm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.(((alpha==zero).or. (k==0)).and. (beta==one))) &
                     return
     
           ! and if  alpha.eq.zero.
     
           if (alpha==zero) then
               if (beta==zero) then
                   do 20 j = 1,n
                       do 10 i = 1,m
                           c(i,j) = zero
        10             continue
        20         continue
               else
                   do 40 j = 1,n
                       do 30 i = 1,m
                           c(i,j) = beta*c(i,j)
        30             continue
        40         continue
               end if
               return
           end if
     
           ! start the operations.
     
           if (notb) then
               if (nota) then
     
                 ! form  c := alpha*a*b + beta*c.
     
                   do 90 j = 1,n
                       if (beta==zero) then
                           do 50 i = 1,m
                               c(i,j) = zero
        50                 continue
                       else if (beta/=one) then
                           do 60 i = 1,m
                               c(i,j) = beta*c(i,j)
        60                 continue
                       end if
                       do 80 l = 1,k
                           temp = alpha*b(l,j)
                           do 70 i = 1,m
                               c(i,j) = c(i,j) + temp*a(i,l)
        70                 continue
        80             continue
        90         continue
               else
     
                 ! form  c := alpha*a**t*b + beta*c
     
                   do 120 j = 1,n
                       do 110 i = 1,m
                           temp = zero
                           do 100 l = 1,k
                               temp = temp + a(l,i)*b(l,j)
       100                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       110             continue
       120         continue
               end if
           else
               if (nota) then
     
                 ! form  c := alpha*a*b**t + beta*c
     
                   do 170 j = 1,n
                       if (beta==zero) then
                           do 130 i = 1,m
                               c(i,j) = zero
       130                 continue
                       else if (beta/=one) then
                           do 140 i = 1,m
                               c(i,j) = beta*c(i,j)
       140                 continue
                       end if
                       do 160 l = 1,k
                           temp = alpha*b(j,l)
                           do 150 i = 1,m
                               c(i,j) = c(i,j) + temp*a(i,l)
       150                 continue
       160             continue
       170         continue
               else
     
                 ! form  c := alpha*a**t*b**t + beta*c
     
                   do 200 j = 1,n
                       do 190 i = 1,m
                           temp = zero
                           do 180 l = 1,k
                               temp = temp + a(l,i)*b(j,l)
       180                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       190             continue
       200         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dgemm
     
     end subroutine stdlib_dgemm
     
     
     subroutine stdlib_dgemv(trans,m,n,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) incx,incy,lda,m,n
           character trans
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,iy,j,jx,jy,kx,ky,lenx,leny
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 1
           else if (m<0) then
               info = 2
           else if (n<0) then
               info = 3
           else if (lda<max(1,m)) then
               info = 6
           else if (incx==0) then
               info = 8
           else if (incy==0) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dgemv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           ! set  lenx  and  leny, the lengths of the vectors x and y, and set
           ! up the start points in  x  and  y.
     
           if (stdlib_lsame(trans,'n')) then
               lenx = n
               leny = m
           else
               lenx = m
               leny = n
           end if
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (lenx-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (leny-1)*incy
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,leny
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,leny
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,leny
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,leny
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           if (stdlib_lsame(trans,'n')) then
     
              ! form  y := alpha*a*x + y.
     
               jx = kx
               if (incy==1) then
                   do 60 j = 1,n
                       temp = alpha*x(jx)
                       do 50 i = 1,m
                           y(i) = y(i) + temp*a(i,j)
        50             continue
                       jx = jx + incx
        60         continue
               else
                   do 80 j = 1,n
                       temp = alpha*x(jx)
                       iy = ky
                       do 70 i = 1,m
                           y(iy) = y(iy) + temp*a(i,j)
                           iy = iy + incy
        70             continue
                       jx = jx + incx
        80         continue
               end if
           else
     
              ! form  y := alpha*a**t*x + y.
     
               jy = ky
               if (incx==1) then
                   do 100 j = 1,n
                       temp = zero
                       do 90 i = 1,m
                           temp = temp + a(i,j)*x(i)
        90             continue
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
       100         continue
               else
                   do 120 j = 1,n
                       temp = zero
                       ix = kx
                       do 110 i = 1,m
                           temp = temp + a(i,j)*x(ix)
                           ix = ix + incx
       110             continue
                       y(jy) = y(jy) + alpha*temp
                       jy = jy + incy
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dgemv
     
     end subroutine stdlib_dgemv
     
     
     subroutine stdlib_dger(m,n,alpha,x,incx,y,incy,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) incx,incy,lda,m,n
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jy,kx
           ! ..
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (m<0) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           else if (lda<max(1,m)) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dger  ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or. (alpha==zero)) return
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (incy>0) then
               jy = 1
           else
               jy = 1 - (n-1)*incy
           end if
           if (incx==1) then
               do 20 j = 1,n
                   if (y(jy)/=zero) then
                       temp = alpha*y(jy)
                       do 10 i = 1,m
                           a(i,j) = a(i,j) + x(i)*temp
        10             continue
                   end if
                   jy = jy + incy
        20     continue
           else
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (m-1)*incx
               end if
               do 40 j = 1,n
                   if (y(jy)/=zero) then
                       temp = alpha*y(jy)
                       ix = kx
                       do 30 i = 1,m
                           a(i,j) = a(i,j) + x(ix)*temp
                           ix = ix + incx
        30             continue
                   end if
                   jy = jy + incy
        40     continue
           end if
     
           return
     
           ! end of stdlib_dger
     
     end subroutine stdlib_dger
     
     
     function stdlib_dnrm2( n, x, incx )
        integer, parameter :: wp = kind(1.d0)
        real(dp) :: stdlib_dnrm2
     
        ! -- reference blas level1 routine (version 3.9.1) --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! march 2021
     
        ! .. constants ..
        real(dp), parameter ::dzero = 0.0_dp
        real(dp), parameter :: done  = 1.0_dp
        real(dp), parameter :: maxn = huge(0.0_dp)
        ! ..
        ! .. blue's scaling constants ..
     real(dp), parameter :: tsml = real(radix(0._dp), wp)**ceiling(       (minexponent(0._dp) - 1)&
                * 0.5_dp)
     real(dp), parameter :: tbig = real(radix(0._dp), wp)**floor(       (maxexponent(0._dp) - &
               digits(0._dp) + 1) * 0.5_dp)
     real(dp), parameter :: ssml = real(radix(0._dp), wp)**( - floor(       (minexponent(0._dp) - &
               digits(0._dp)) * 0.5_dp))
     real(dp), parameter :: sbig = real(radix(0._dp), wp)**( - ceiling(       (maxexponent(0._dp) &
               + digits(0._dp) - 1) * 0.5_dp))
        ! ..
        ! .. scalar arguments ..
        integer :: incx, n
        ! ..
        ! .. array arguments ..
        real(dp) :: x(*)
        ! ..
        ! .. local scalars ..
        integer :: i, ix
        logical :: notbig
        real(dp) :: abig, amed, asml, ax, scl, sumsq, ymax, ymin
     
        ! quick return if possible
     
        stdlib_dnrm2 =dzero
        if( n <= 0 ) return
     
        scl = done
        sumsq =dzero
     
        ! compute the sum of squares in 3 accumulators:
           ! abig -- sums of squares scaled down to avoid overflow
           ! asml -- sums of squares scaled up to avoid underflow
           ! amed -- sums of squares that do not require scaling
        ! the thresholds and multipliers are
           ! tbig -- values bigger than this are scaled down by sbig
           ! tsml -- values smaller than this are scaled up by ssml
     
        notbig = .true.
        asml =dzero
        amed =dzero
        abig =dzero
        ix = 1
        if( incx < 0 ) ix = 1 - (n-1)*incx
        do i = 1, n
           ax = abs(x(ix))
           if (ax > tbig) then
              abig = abig + (ax*sbig)**2
              notbig = .false.
           else if (ax < tsml) then
              if (notbig) asml = asml + (ax*ssml)**2
           else
              amed = amed + ax**2
           end if
           ix = ix + incx
        end do
     
        ! combine abig and amed or amed and asml if more than done
        ! accumulator was used.
     
        if (abig >dzero) then
     
           ! combine abig and amed if abig > 0.
     
           if ( (amed >dzero) .or. (amed > maxn) .or. (amed /= amed) ) then
              abig = abig + (amed*sbig)*sbig
           end if
           scl = done / sbig
           sumsq = abig
        else if (asml >dzero) then
     
           ! combine amed and asml if asml > 0.
     
           if ( (amed >dzero) .or. (amed > maxn) .or. (amed /= amed) ) then
              amed = sqrt(amed)
              asml = sqrt(asml) / ssml
              if (asml > amed) then
                 ymin = amed
                 ymax = asml
              else
                 ymin = asml
                 ymax = amed
              end if
              scl = done
              sumsq = ymax**2*( done + (ymin/ymax)**2 )
           else
              scl = done / ssml
              sumsq = asml
           end if
        else
     
           ! otherwise all values are mid-range
     
           scl = done
           sumsq = amed
        end if
        stdlib_dnrm2 = scl*sqrt( sumsq )
        return
     end function stdlib_dnrm2
     
     
     subroutine stdlib_drot(n,dx,incx,dy,incy,c,s)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) c,s
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*),dy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) dtemp
           integer(int32) i,ix,iy
           ! ..
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
             ! code for both increments equal to 1
     
              do i = 1,n
                 dtemp = c*dx(i) + s*dy(i)
                 dy(i) = c*dy(i) - s*dx(i)
                 dx(i) = dtemp
              end do
           else
     
             ! code for unequal increments or equal increments not equal
               ! to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 dtemp = c*dx(ix) + s*dy(iy)
                 dy(iy) = c*dy(iy) - s*dx(ix)
                 dx(ix) = dtemp
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_drot
     
     end subroutine stdlib_drot
     
     
     subroutine stdlib_drotg( a, b, c, s )
        integer, parameter :: wp = kind(1.d0)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
        ! .. constants ..
        real(dp), parameter ::dzero = 0.0_dp
        real(dp), parameter :: done  = 1.0_dp
        ! ..
        ! .. scaling constants ..
     real(dp), parameter :: safmin = real(radix(0._dp),wp)**max(minexponent(0._dp)-1,1-&
               maxexponent(0._dp)   )
     real(dp), parameter :: safmax = real(radix(0._dp),wp)**max(1-minexponent(0._dp),maxexponent(&
               0._dp)-1   )
        ! ..
        ! .. scalar arguments ..
        real(dp) :: a, b, c, s
        ! ..
        ! .. local scalars ..
        real(dp) :: anorm, bnorm, scl, sigma, r, z
        ! ..
        anorm = abs(a)
        bnorm = abs(b)
        if( bnorm ==dzero ) then
           c = done
           s =dzero
           b =dzero
        else if( anorm ==dzero ) then
           c =dzero
           s = done
           a = b
           b = done
        else
           scl = min( safmax, max( safmin, anorm, bnorm ) )
           if( anorm > bnorm ) then
              sigma = sign(done,a)
           else
              sigma = sign(done,b)
           end if
           r = sigma*( scl*sqrt((a/scl)**2 + (b/scl)**2) )
           c = a/r
           s = b/r
           if( anorm > bnorm ) then
              z = s
           else if( c /=dzero ) then
              z = done/c
           else
              z = done
           end if
           a = r
           b = z
        end if
        return
     end subroutine stdlib_drotg
     
     
     subroutine stdlib_drotm(n,dx,incx,dy,incy,dparam)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(dp) dparam(5),dx(*),dy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) dflag,dh11,dh12,dh21,dh22,two,w,z,zero
           integer(int32) i,kx,ky,nsteps
           ! ..
           ! .. data statements ..
           data zero,two/0.d0,2.d0/
           ! ..
     
           dflag = dparam(1)
           if (n<=0 .or. (dflag+two==zero)) return
           if (incx==incy.and.incx>0) then
     
              nsteps = n*incx
              if (dflag<zero) then
                 dh11 = dparam(2)
                 dh12 = dparam(4)
                 dh21 = dparam(3)
                 dh22 = dparam(5)
                 do i = 1,nsteps,incx
                    w = dx(i)
                    z = dy(i)
                    dx(i) = w*dh11 + z*dh12
                    dy(i) = w*dh21 + z*dh22
                 end do
              else if (dflag==zero) then
                 dh12 = dparam(4)
                 dh21 = dparam(3)
                 do i = 1,nsteps,incx
                    w = dx(i)
                    z = dy(i)
                    dx(i) = w + z*dh12
                    dy(i) = w*dh21 + z
                 end do
              else
                 dh11 = dparam(2)
                 dh22 = dparam(5)
                 do i = 1,nsteps,incx
                    w = dx(i)
                    z = dy(i)
                    dx(i) = w*dh11 + z
                    dy(i) = -w + dh22*z
                 end do
              end if
           else
              kx = 1
              ky = 1
              if (incx<0) kx = 1 + (1-n)*incx
              if (incy<0) ky = 1 + (1-n)*incy
     
              if (dflag<zero) then
                 dh11 = dparam(2)
                 dh12 = dparam(4)
                 dh21 = dparam(3)
                 dh22 = dparam(5)
                 do i = 1,n
                    w = dx(kx)
                    z = dy(ky)
                    dx(kx) = w*dh11 + z*dh12
                    dy(ky) = w*dh21 + z*dh22
                    kx = kx + incx
                    ky = ky + incy
                 end do
              else if (dflag==zero) then
                 dh12 = dparam(4)
                 dh21 = dparam(3)
                 do i = 1,n
                    w = dx(kx)
                    z = dy(ky)
                    dx(kx) = w + z*dh12
                    dy(ky) = w*dh21 + z
                    kx = kx + incx
                    ky = ky + incy
                 end do
              else
                  dh11 = dparam(2)
                  dh22 = dparam(5)
                  do i = 1,n
                     w = dx(kx)
                     z = dy(ky)
                     dx(kx) = w*dh11 + z
                     dy(ky) = -w + dh22*z
                     kx = kx + incx
                     ky = ky + incy
                 end do
              end if
           end if
           return
     
           ! end of stdlib_drotm
     
     end subroutine stdlib_drotm
     
     
     subroutine stdlib_drotmg(dd1,dd2,dx1,dy1,dparam)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) dd1,dd2,dx1,dy1
           ! ..
           ! .. array arguments ..
           real(dp) dparam(5)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) dflag,dh11,dh12,dh21,dh22,dp1,dp2,dq1,dq2,dtemp,du,gam,gamsq,one,rgamsq,two,&
                     zero
           ! ..
           ! .. intrinsic functions ..
           intrinsic dabs
           ! ..
           ! .. data statements ..
     
           data zero,one,two/0.d0,1.d0,2.d0/
           data gam,gamsq,rgamsq/4096.d0,16777216.d0,5.9604645d-8/
           ! ..
           if (dd1<zero) then
              ! go zero-h-d-and-dx1..
              dflag = -one
              dh11 = zero
              dh12 = zero
              dh21 = zero
              dh22 = zero
     
              dd1 = zero
              dd2 = zero
              dx1 = zero
           else
              ! case-dd1-nonnegative
              dp2 = dd2*dy1
              if (dp2==zero) then
                 dflag = -two
                 dparam(1) = dflag
                 return
              end if
              ! regular-case..
              dp1 = dd1*dx1
              dq2 = dp2*dy1
              dq1 = dp1*dx1
     
              if (dabs(dq1)>dabs(dq2)) then
                 dh21 = -dy1/dx1
                 dh12 = dp2/dp1
     
                 du = one - dh12*dh21
     
                if (du>zero) then
                  dflag = zero
                  dd1 = dd1/du
                  dd2 = dd2/du
                  dx1 = dx1*du
                else
                  ! this code path if here for safety. we do not expect this
                  ! condition to ever hold except in edge cases with rounding
                  ! errors. see doi: 10.1145/355841.355847
                  dflag = -one
                  dh11 = zero
                  dh12 = zero
                  dh21 = zero
                  dh22 = zero
     
                  dd1 = zero
                  dd2 = zero
                  dx1 = zero
                end if
              else
                 if (dq2<zero) then
                    ! go zero-h-d-and-dx1..
                    dflag = -one
                    dh11 = zero
                    dh12 = zero
                    dh21 = zero
                    dh22 = zero
     
                    dd1 = zero
                    dd2 = zero
                    dx1 = zero
                 else
                    dflag = one
                    dh11 = dp1/dp2
                    dh22 = dx1/dy1
                    du = one + dh11*dh22
                    dtemp = dd2/du
                    dd2 = dd1/du
                    dd1 = dtemp
                    dx1 = dy1*du
                 end if
              end if
           ! procedure..scale-check
              if (dd1/=zero) then
                 do while ((dd1<=rgamsq) .or. (dd1>=gamsq))
                    if (dflag==zero) then
                       dh11 = one
                       dh22 = one
                       dflag = -one
                    else
                       dh21 = -one
                       dh12 = one
                       dflag = -one
                    end if
                    if (dd1<=rgamsq) then
                       dd1 = dd1*gam**2
                       dx1 = dx1/gam
                       dh11 = dh11/gam
                       dh12 = dh12/gam
                    else
                       dd1 = dd1/gam**2
                       dx1 = dx1*gam
                       dh11 = dh11*gam
                       dh12 = dh12*gam
                    end if
                 enddo
              end if
              if (dd2/=zero) then
                 do while ( (dabs(dd2)<=rgamsq) .or. (dabs(dd2)>=gamsq) )
                    if (dflag==zero) then
                       dh11 = one
                       dh22 = one
                       dflag = -one
                    else
                       dh21 = -one
                       dh12 = one
                       dflag = -one
                    end if
                    if (dabs(dd2)<=rgamsq) then
                       dd2 = dd2*gam**2
                       dh21 = dh21/gam
                       dh22 = dh22/gam
                    else
                       dd2 = dd2/gam**2
                       dh21 = dh21*gam
                       dh22 = dh22*gam
                    end if
                 end do
              end if
           end if
           if (dflag<zero) then
              dparam(2) = dh11
              dparam(3) = dh21
              dparam(4) = dh12
              dparam(5) = dh22
           else if (dflag==zero) then
              dparam(3) = dh21
              dparam(4) = dh12
           else
              dparam(2) = dh11
              dparam(5) = dh22
           end if
           dparam(1) = dflag
           return
     
           ! end of stdlib_drotmg
     
     end subroutine stdlib_drotmg
     
     
     subroutine stdlib_dsbmv(uplo,n,k,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) incx,incy,k,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,kplus1,kx,ky,l
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (k<0) then
               info = 3
           else if (lda< (k+1)) then
               info = 6
           else if (incx==0) then
               info = 8
           else if (incy==0) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsbmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. ((alpha==zero).and. (beta==one))) return
     
           ! set up the start points in  x  and  y.
     
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (n-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (n-1)*incy
           end if
     
           ! start the operations. in this version the elements of the array a
           ! are accessed sequentially with one pass through a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,n
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,n
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,n
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,n
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  y  when upper triangle of a is stored.
     
               kplus1 = k + 1
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       l = kplus1 - j
                       do 50 i = max(1,j-k),j - 1
                           y(i) = y(i) + temp1*a(l+i,j)
                           temp2 = temp2 + a(l+i,j)*x(i)
        50             continue
                       y(j) = y(j) + temp1*a(kplus1,j) + alpha*temp2
        60         continue
               else
                   jx = kx
                   jy = ky
                   do 80 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       ix = kx
                       iy = ky
                       l = kplus1 - j
                       do 70 i = max(1,j-k),j - 1
                           y(iy) = y(iy) + temp1*a(l+i,j)
                           temp2 = temp2 + a(l+i,j)*x(ix)
                           ix = ix + incx
                           iy = iy + incy
        70             continue
                       y(jy) = y(jy) + temp1*a(kplus1,j) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
                       if (j>k) then
                           kx = kx + incx
                           ky = ky + incy
                       end if
        80         continue
               end if
           else
     
              ! form  y  when lower triangle of a is stored.
     
               if ((incx==1) .and. (incy==1)) then
                   do 100 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       y(j) = y(j) + temp1*a(1,j)
                       l = 1 - j
                       do 90 i = j + 1,min(n,j+k)
                           y(i) = y(i) + temp1*a(l+i,j)
                           temp2 = temp2 + a(l+i,j)*x(i)
        90             continue
                       y(j) = y(j) + alpha*temp2
       100         continue
               else
                   jx = kx
                   jy = ky
                   do 120 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       y(jy) = y(jy) + temp1*a(1,j)
                       l = 1 - j
                       ix = jx
                       iy = jy
                       do 110 i = j + 1,min(n,j+k)
                           ix = ix + incx
                           iy = iy + incy
                           y(iy) = y(iy) + temp1*a(l+i,j)
                           temp2 = temp2 + a(l+i,j)*x(ix)
       110             continue
                       y(jy) = y(jy) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dsbmv
     
     end subroutine stdlib_dsbmv
     
     
     subroutine stdlib_dscal(n,da,dx,incx)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) da
           integer(int32) incx,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,m,mp1,nincx
           ! ..
           ! .. intrinsic functions ..
           intrinsic mod
           ! ..
           if (n<=0 .or. incx<=0) return
           if (incx==1) then
     
              ! code for increment equal to 1
     
     
              ! clean-up loop
     
              m = mod(n,5)
              if (m/=0) then
                 do i = 1,m
                    dx(i) = da*dx(i)
                 end do
                 if (n<5) return
              end if
              mp1 = m + 1
              do i = mp1,n,5
                 dx(i) = da*dx(i)
                 dx(i+1) = da*dx(i+1)
                 dx(i+2) = da*dx(i+2)
                 dx(i+3) = da*dx(i+3)
                 dx(i+4) = da*dx(i+4)
              end do
           else
     
              ! code for increment not equal to 1
     
              nincx = n*incx
              do i = 1,nincx,incx
                 dx(i) = da*dx(i)
              end do
           end if
           return
     
           ! end of stdlib_dscal
     
     end subroutine stdlib_dscal
     
     
     real(dp) function stdlib_dsdot(n,sx,incx,sy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(sp) sx(*),sy(*)
           ! ..
     
        ! authors:
        ! ========
        ! lawson, c. l., (jpl), hanson, r. j., (snla),
        ! kincaid, d. r., (u. of texas), krogh, f. t., (jpl)
     
        ! =====================================================================
     
           ! .. local scalars ..
           integer(int32) i,kx,ky,ns
           ! ..
           ! .. intrinsic functions ..
           intrinsic dble
           ! ..
           stdlib_dsdot = 0.0d0
           if (n<=0) return
           if (incx==incy .and. incx>0) then
     
           ! code for equal, positive, non-unit increments.
     
              ns = n*incx
              do i = 1,ns,incx
                 stdlib_dsdot = stdlib_dsdot + dble(sx(i))*dble(sy(i))
              end do
           else
     
           ! code for unequal or nonpositive increments.
     
              kx = 1
              ky = 1
              if (incx<0) kx = 1 + (1-n)*incx
              if (incy<0) ky = 1 + (1-n)*incy
              do i = 1,n
                 stdlib_dsdot = stdlib_dsdot + dble(sx(kx))*dble(sy(ky))
                 kx = kx + incx
                 ky = ky + incy
              end do
           end if
           return
     
           ! end of stdlib_dsdot
     
     end function stdlib_dsdot
     
     
     subroutine stdlib_dspmv(uplo,n,alpha,ap,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) incx,incy,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) ap(*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,k,kk,kx,ky
           ! ..
     
     
     
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 6
           else if (incy==0) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dspmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. ((alpha==zero).and. (beta==one))) return
     
           ! set up the start points in  x  and  y.
     
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (n-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (n-1)*incy
           end if
     
           ! start the operations. in this version the elements of the array ap
           ! are accessed sequentially with one pass through ap.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,n
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,n
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,n
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,n
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           kk = 1
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  y  when ap contains the upper triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       k = kk
                       do 50 i = 1,j - 1
                           y(i) = y(i) + temp1*ap(k)
                           temp2 = temp2 + ap(k)*x(i)
                           k = k + 1
        50             continue
                       y(j) = y(j) + temp1*ap(kk+j-1) + alpha*temp2
                       kk = kk + j
        60         continue
               else
                   jx = kx
                   jy = ky
                   do 80 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       ix = kx
                       iy = ky
                       do 70 k = kk,kk + j - 2
                           y(iy) = y(iy) + temp1*ap(k)
                           temp2 = temp2 + ap(k)*x(ix)
                           ix = ix + incx
                           iy = iy + incy
        70             continue
                       y(jy) = y(jy) + temp1*ap(kk+j-1) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + j
        80         continue
               end if
           else
     
              ! form  y  when ap contains the lower triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 100 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       y(j) = y(j) + temp1*ap(kk)
                       k = kk + 1
                       do 90 i = j + 1,n
                           y(i) = y(i) + temp1*ap(k)
                           temp2 = temp2 + ap(k)*x(i)
                           k = k + 1
        90             continue
                       y(j) = y(j) + alpha*temp2
                       kk = kk + (n-j+1)
       100         continue
               else
                   jx = kx
                   jy = ky
                   do 120 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       y(jy) = y(jy) + temp1*ap(kk)
                       ix = jx
                       iy = jy
                       do 110 k = kk + 1,kk + n - j
                           ix = ix + incx
                           iy = iy + incy
                           y(iy) = y(iy) + temp1*ap(k)
                           temp2 = temp2 + ap(k)*x(ix)
       110             continue
                       y(jy) = y(jy) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + (n-j+1)
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dspmv
     
     end subroutine stdlib_dspmv
     
     
     subroutine stdlib_dspr(uplo,n,alpha,x,incx,ap)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) incx,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) ap(*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,k,kk,kx
           ! ..
     
     
     
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dspr  ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==zero)) return
     
           ! set the start point in x if the increment is not unity.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of the array ap
           ! are accessed sequentially with one pass through ap.
     
           kk = 1
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when upper triangle is stored in ap.
     
               if (incx==1) then
                   do 20 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*x(j)
                           k = kk
                           do 10 i = 1,j
                               ap(k) = ap(k) + x(i)*temp
                               k = k + 1
        10                 continue
                       end if
                       kk = kk + j
        20         continue
               else
                   jx = kx
                   do 40 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*x(jx)
                           ix = kx
                           do 30 k = kk,kk + j - 1
                               ap(k) = ap(k) + x(ix)*temp
                               ix = ix + incx
        30                 continue
                       end if
                       jx = jx + incx
                       kk = kk + j
        40         continue
               end if
           else
     
              ! form  a  when lower triangle is stored in ap.
     
               if (incx==1) then
                   do 60 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*x(j)
                           k = kk
                           do 50 i = j,n
                               ap(k) = ap(k) + x(i)*temp
                               k = k + 1
        50                 continue
                       end if
                       kk = kk + n - j + 1
        60         continue
               else
                   jx = kx
                   do 80 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*x(jx)
                           ix = jx
                           do 70 k = kk,kk + n - j
                               ap(k) = ap(k) + x(ix)*temp
                               ix = ix + incx
        70                 continue
                       end if
                       jx = jx + incx
                       kk = kk + n - j + 1
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dspr
     
     end subroutine stdlib_dspr
     
     
     subroutine stdlib_dspr2(uplo,n,alpha,x,incx,y,incy,ap)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) incx,incy,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) ap(*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,k,kk,kx,ky
           ! ..
     
     
     
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dspr2 ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==zero)) return
     
           ! set up the start points in x and y if the increments are not both
           ! unity.
     
           if ((incx/=1) .or. (incy/=1)) then
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (n-1)*incx
               end if
               if (incy>0) then
                   ky = 1
               else
                   ky = 1 - (n-1)*incy
               end if
               jx = kx
               jy = ky
           end if
     
           ! start the operations. in this version the elements of the array ap
           ! are accessed sequentially with one pass through ap.
     
           kk = 1
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when upper triangle is stored in ap.
     
               if ((incx==1) .and. (incy==1)) then
                   do 20 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*y(j)
                           temp2 = alpha*x(j)
                           k = kk
                           do 10 i = 1,j
                               ap(k) = ap(k) + x(i)*temp1 + y(i)*temp2
                               k = k + 1
        10                 continue
                       end if
                       kk = kk + j
        20         continue
               else
                   do 40 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*y(jy)
                           temp2 = alpha*x(jx)
                           ix = kx
                           iy = ky
                           do 30 k = kk,kk + j - 1
                               ap(k) = ap(k) + x(ix)*temp1 + y(iy)*temp2
                               ix = ix + incx
                               iy = iy + incy
        30                 continue
                       end if
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + j
        40         continue
               end if
           else
     
              ! form  a  when lower triangle is stored in ap.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*y(j)
                           temp2 = alpha*x(j)
                           k = kk
                           do 50 i = j,n
                               ap(k) = ap(k) + x(i)*temp1 + y(i)*temp2
                               k = k + 1
        50                 continue
                       end if
                       kk = kk + n - j + 1
        60         continue
               else
                   do 80 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*y(jy)
                           temp2 = alpha*x(jx)
                           ix = jx
                           iy = jy
                           do 70 k = kk,kk + n - j
                               ap(k) = ap(k) + x(ix)*temp1 + y(iy)*temp2
                               ix = ix + incx
                               iy = iy + incy
        70                 continue
                       end if
                       jx = jx + incx
                       jy = jy + incy
                       kk = kk + n - j + 1
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dspr2
     
     end subroutine stdlib_dspr2
     
     
     subroutine stdlib_dswap(n,dx,incx,dy,incy)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,incy,n
           ! ..
           ! .. array arguments ..
           real(dp) dx(*),dy(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) dtemp
           integer(int32) i,ix,iy,m,mp1
           ! ..
           ! .. intrinsic functions ..
           intrinsic mod
           ! ..
           if (n<=0) return
           if (incx==1 .and. incy==1) then
     
             ! code for both increments equal to 1
     
     
             ! clean-up loop
     
              m = mod(n,3)
              if (m/=0) then
                 do i = 1,m
                    dtemp = dx(i)
                    dx(i) = dy(i)
                    dy(i) = dtemp
                 end do
                 if (n<3) return
              end if
              mp1 = m + 1
              do i = mp1,n,3
                 dtemp = dx(i)
                 dx(i) = dy(i)
                 dy(i) = dtemp
                 dtemp = dx(i+1)
                 dx(i+1) = dy(i+1)
                 dy(i+1) = dtemp
                 dtemp = dx(i+2)
                 dx(i+2) = dy(i+2)
                 dy(i+2) = dtemp
              end do
           else
     
             ! code for unequal increments or equal increments not equal
               ! to 1
     
              ix = 1
              iy = 1
              if (incx<0) ix = (-n+1)*incx + 1
              if (incy<0) iy = (-n+1)*incy + 1
              do i = 1,n
                 dtemp = dx(ix)
                 dx(ix) = dy(iy)
                 dy(iy) = dtemp
                 ix = ix + incx
                 iy = iy + incy
              end do
           end if
           return
     
           ! end of stdlib_dswap
     
     end subroutine stdlib_dswap
     
     
     subroutine stdlib_dsymm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) lda,ldb,ldc,m,n
           character side,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,j,k,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
     
           ! set nrowa as the number of rows of a.
     
           if (stdlib_lsame(side,'l')) then
               nrowa = m
           else
               nrowa = n
           end if
           upper = stdlib_lsame(uplo,'u')
     
           ! test the input parameters.
     
           info = 0
           if ((.not.stdlib_lsame(side,'l')) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if (m<0) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldb<max(1,m)) then
               info = 9
           else if (ldc<max(1,m)) then
               info = 12
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsymm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((m==0) .or. (n==0) .or.((alpha==zero).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (beta==zero) then
                   do 20 j = 1,n
                       do 10 i = 1,m
                           c(i,j) = zero
        10             continue
        20         continue
               else
                   do 40 j = 1,n
                       do 30 i = 1,m
                           c(i,j) = beta*c(i,j)
        30             continue
        40         continue
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(side,'l')) then
     
              ! form  c := alpha*a*b + beta*c.
     
               if (upper) then
                   do 70 j = 1,n
                       do 60 i = 1,m
                           temp1 = alpha*b(i,j)
                           temp2 = zero
                           do 50 k = 1,i - 1
                               c(k,j) = c(k,j) + temp1*a(k,i)
                               temp2 = temp2 + b(k,j)*a(k,i)
        50                 continue
                           if (beta==zero) then
                               c(i,j) = temp1*a(i,i) + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + temp1*a(i,i) +alpha*temp2
                           end if
        60             continue
        70         continue
               else
                   do 100 j = 1,n
                       do 90 i = m,1,-1
                           temp1 = alpha*b(i,j)
                           temp2 = zero
                           do 80 k = i + 1,m
                               c(k,j) = c(k,j) + temp1*a(k,i)
                               temp2 = temp2 + b(k,j)*a(k,i)
        80                 continue
                           if (beta==zero) then
                               c(i,j) = temp1*a(i,i) + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + temp1*a(i,i) +alpha*temp2
                           end if
        90             continue
       100         continue
               end if
           else
     
              ! form  c := alpha*b*a + beta*c.
     
               do 170 j = 1,n
                   temp1 = alpha*a(j,j)
                   if (beta==zero) then
                       do 110 i = 1,m
                           c(i,j) = temp1*b(i,j)
       110             continue
                   else
                       do 120 i = 1,m
                           c(i,j) = beta*c(i,j) + temp1*b(i,j)
       120             continue
                   end if
                   do 140 k = 1,j - 1
                       if (upper) then
                           temp1 = alpha*a(k,j)
                       else
                           temp1 = alpha*a(j,k)
                       end if
                       do 130 i = 1,m
                           c(i,j) = c(i,j) + temp1*b(i,k)
       130             continue
       140         continue
                   do 160 k = j + 1,n
                       if (upper) then
                           temp1 = alpha*a(j,k)
                       else
                           temp1 = alpha*a(k,j)
                       end if
                       do 150 i = 1,m
                           c(i,j) = c(i,j) + temp1*b(i,k)
       150             continue
       160         continue
       170     continue
           end if
     
           return
     
           ! end of stdlib_dsymm
     
     end subroutine stdlib_dsymm
     
     
     subroutine stdlib_dsymv(uplo,n,alpha,a,lda,x,incx,beta,y,incy)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) incx,incy,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,kx,ky
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (lda<max(1,n)) then
               info = 5
           else if (incx==0) then
               info = 7
           else if (incy==0) then
               info = 10
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsymv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. ((alpha==zero).and. (beta==one))) return
     
           ! set up the start points in  x  and  y.
     
           if (incx>0) then
               kx = 1
           else
               kx = 1 - (n-1)*incx
           end if
           if (incy>0) then
               ky = 1
           else
               ky = 1 - (n-1)*incy
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the triangular part
           ! of a.
     
           ! first form  y := beta*y.
     
           if (beta/=one) then
               if (incy==1) then
                   if (beta==zero) then
                       do 10 i = 1,n
                           y(i) = zero
        10             continue
                   else
                       do 20 i = 1,n
                           y(i) = beta*y(i)
        20             continue
                   end if
               else
                   iy = ky
                   if (beta==zero) then
                       do 30 i = 1,n
                           y(iy) = zero
                           iy = iy + incy
        30             continue
                   else
                       do 40 i = 1,n
                           y(iy) = beta*y(iy)
                           iy = iy + incy
        40             continue
                   end if
               end if
           end if
           if (alpha==zero) return
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  y  when a is stored in upper triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       do 50 i = 1,j - 1
                           y(i) = y(i) + temp1*a(i,j)
                           temp2 = temp2 + a(i,j)*x(i)
        50             continue
                       y(j) = y(j) + temp1*a(j,j) + alpha*temp2
        60         continue
               else
                   jx = kx
                   jy = ky
                   do 80 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       ix = kx
                       iy = ky
                       do 70 i = 1,j - 1
                           y(iy) = y(iy) + temp1*a(i,j)
                           temp2 = temp2 + a(i,j)*x(ix)
                           ix = ix + incx
                           iy = iy + incy
        70             continue
                       y(jy) = y(jy) + temp1*a(j,j) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
        80         continue
               end if
           else
     
              ! form  y  when a is stored in lower triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 100 j = 1,n
                       temp1 = alpha*x(j)
                       temp2 = zero
                       y(j) = y(j) + temp1*a(j,j)
                       do 90 i = j + 1,n
                           y(i) = y(i) + temp1*a(i,j)
                           temp2 = temp2 + a(i,j)*x(i)
        90             continue
                       y(j) = y(j) + alpha*temp2
       100         continue
               else
                   jx = kx
                   jy = ky
                   do 120 j = 1,n
                       temp1 = alpha*x(jx)
                       temp2 = zero
                       y(jy) = y(jy) + temp1*a(j,j)
                       ix = jx
                       iy = jy
                       do 110 i = j + 1,n
                           ix = ix + incx
                           iy = iy + incy
                           y(iy) = y(iy) + temp1*a(i,j)
                           temp2 = temp2 + a(i,j)*x(ix)
       110             continue
                       y(jy) = y(jy) + alpha*temp2
                       jx = jx + incx
                       jy = jy + incy
       120         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dsymv
     
     end subroutine stdlib_dsymv
     
     
     subroutine stdlib_dsyr(uplo,n,alpha,x,incx,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) incx,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,kx
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (lda<max(1,n)) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsyr  ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==zero)) return
     
           ! set the start point in x if the increment is not unity.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the triangular part
           ! of a.
     
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when a is stored in upper triangle.
     
               if (incx==1) then
                   do 20 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*x(j)
                           do 10 i = 1,j
                               a(i,j) = a(i,j) + x(i)*temp
        10                 continue
                       end if
        20         continue
               else
                   jx = kx
                   do 40 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*x(jx)
                           ix = kx
                           do 30 i = 1,j
                               a(i,j) = a(i,j) + x(ix)*temp
                               ix = ix + incx
        30                 continue
                       end if
                       jx = jx + incx
        40         continue
               end if
           else
     
              ! form  a  when a is stored in lower triangle.
     
               if (incx==1) then
                   do 60 j = 1,n
                       if (x(j)/=zero) then
                           temp = alpha*x(j)
                           do 50 i = j,n
                               a(i,j) = a(i,j) + x(i)*temp
        50                 continue
                       end if
        60         continue
               else
                   jx = kx
                   do 80 j = 1,n
                       if (x(jx)/=zero) then
                           temp = alpha*x(jx)
                           ix = jx
                           do 70 i = j,n
                               a(i,j) = a(i,j) + x(ix)*temp
                               ix = ix + incx
        70                 continue
                       end if
                       jx = jx + incx
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dsyr
     
     end subroutine stdlib_dsyr
     
     
     subroutine stdlib_dsyr2(uplo,n,alpha,x,incx,y,incy,a,lda)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) incx,incy,lda,n
           character uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*),y(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,ix,iy,j,jx,jy,kx,ky
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (n<0) then
               info = 2
           else if (incx==0) then
               info = 5
           else if (incy==0) then
               info = 7
           else if (lda<max(1,n)) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsyr2 ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (alpha==zero)) return
     
           ! set up the start points in x and y if the increments are not both
           ! unity.
     
           if ((incx/=1) .or. (incy/=1)) then
               if (incx>0) then
                   kx = 1
               else
                   kx = 1 - (n-1)*incx
               end if
               if (incy>0) then
                   ky = 1
               else
                   ky = 1 - (n-1)*incy
               end if
               jx = kx
               jy = ky
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through the triangular part
           ! of a.
     
           if (stdlib_lsame(uplo,'u')) then
     
              ! form  a  when a is stored in the upper triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 20 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*y(j)
                           temp2 = alpha*x(j)
                           do 10 i = 1,j
                               a(i,j) = a(i,j) + x(i)*temp1 + y(i)*temp2
        10                 continue
                       end if
        20         continue
               else
                   do 40 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*y(jy)
                           temp2 = alpha*x(jx)
                           ix = kx
                           iy = ky
                           do 30 i = 1,j
                               a(i,j) = a(i,j) + x(ix)*temp1 + y(iy)*temp2
                               ix = ix + incx
                               iy = iy + incy
        30                 continue
                       end if
                       jx = jx + incx
                       jy = jy + incy
        40         continue
               end if
           else
     
              ! form  a  when a is stored in the lower triangle.
     
               if ((incx==1) .and. (incy==1)) then
                   do 60 j = 1,n
                       if ((x(j)/=zero) .or. (y(j)/=zero)) then
                           temp1 = alpha*y(j)
                           temp2 = alpha*x(j)
                           do 50 i = j,n
                               a(i,j) = a(i,j) + x(i)*temp1 + y(i)*temp2
        50                 continue
                       end if
        60         continue
               else
                   do 80 j = 1,n
                       if ((x(jx)/=zero) .or. (y(jy)/=zero)) then
                           temp1 = alpha*y(jy)
                           temp2 = alpha*x(jx)
                           ix = jx
                           iy = jy
                           do 70 i = j,n
                               a(i,j) = a(i,j) + x(ix)*temp1 + y(iy)*temp2
                               ix = ix + incx
                               iy = iy + incy
        70                 continue
                       end if
                       jx = jx + incx
                       jy = jy + incy
        80         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dsyr2
     
     end subroutine stdlib_dsyr2
     
     
     subroutine stdlib_dsyr2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) k,lda,ldb,ldc,n
           character trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),b(ldb,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           real(dp) temp1,temp2
           integer(int32) i,info,j,l,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
     
           ! test the input parameters.
     
           if (stdlib_lsame(trans,'n')) then
               nrowa = n
           else
               nrowa = k
           end if
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 1
           else if ((.not.stdlib_lsame(trans,'n')) .and.(.not.stdlib_lsame(trans,'t')) .and.(&
                     .not.stdlib_lsame(trans,'c'))) then
               info = 2
           else if (n<0) then
               info = 3
           else if (k<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldb<max(1,nrowa)) then
               info = 9
           else if (ldc<max(1,n)) then
               info = 12
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsyr2k',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (((alpha==zero).or.(k==0)).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (upper) then
                   if (beta==zero) then
                       do 20 j = 1,n
                           do 10 i = 1,j
                               c(i,j) = zero
        10                 continue
        20             continue
                   else
                       do 40 j = 1,n
                           do 30 i = 1,j
                               c(i,j) = beta*c(i,j)
        30                 continue
        40             continue
                   end if
               else
                   if (beta==zero) then
                       do 60 j = 1,n
                           do 50 i = j,n
                               c(i,j) = zero
        50                 continue
        60             continue
                   else
                       do 80 j = 1,n
                           do 70 i = j,n
                               c(i,j) = beta*c(i,j)
        70                 continue
        80             continue
                   end if
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  c := alpha*a*b**t + alpha*b*a**t + c.
     
               if (upper) then
                   do 130 j = 1,n
                       if (beta==zero) then
                           do 90 i = 1,j
                               c(i,j) = zero
        90                 continue
                       else if (beta/=one) then
                           do 100 i = 1,j
                               c(i,j) = beta*c(i,j)
       100                 continue
                       end if
                       do 120 l = 1,k
                           if ((a(j,l)/=zero) .or. (b(j,l)/=zero)) then
                               temp1 = alpha*b(j,l)
                               temp2 = alpha*a(j,l)
                               do 110 i = 1,j
                                   c(i,j) = c(i,j) + a(i,l)*temp1 +b(i,l)*temp2
       110                     continue
                           end if
       120             continue
       130         continue
               else
                   do 180 j = 1,n
                       if (beta==zero) then
                           do 140 i = j,n
                               c(i,j) = zero
       140                 continue
                       else if (beta/=one) then
                           do 150 i = j,n
                               c(i,j) = beta*c(i,j)
       150                 continue
                       end if
                       do 170 l = 1,k
                           if ((a(j,l)/=zero) .or. (b(j,l)/=zero)) then
                               temp1 = alpha*b(j,l)
                               temp2 = alpha*a(j,l)
                               do 160 i = j,n
                                   c(i,j) = c(i,j) + a(i,l)*temp1 +b(i,l)*temp2
       160                     continue
                           end if
       170             continue
       180         continue
               end if
           else
     
              ! form  c := alpha*a**t*b + alpha*b**t*a + c.
     
               if (upper) then
                   do 210 j = 1,n
                       do 200 i = 1,j
                           temp1 = zero
                           temp2 = zero
                           do 190 l = 1,k
                               temp1 = temp1 + a(l,i)*b(l,j)
                               temp2 = temp2 + b(l,i)*a(l,j)
       190                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp1 + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + alpha*temp1 +alpha*temp2
                           end if
       200             continue
       210         continue
               else
                   do 240 j = 1,n
                       do 230 i = j,n
                           temp1 = zero
                           temp2 = zero
                           do 220 l = 1,k
                               temp1 = temp1 + a(l,i)*b(l,j)
                               temp2 = temp2 + b(l,i)*a(l,j)
       220                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp1 + alpha*temp2
                           else
                               c(i,j) = beta*c(i,j) + alpha*temp1 +alpha*temp2
                           end if
       230             continue
       240         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dsyr2k
     
     end subroutine stdlib_dsyr2k
     
     
     subroutine stdlib_dsyrk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha,beta
           integer(int32) k,lda,ldc,n
           character trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),c(ldc,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,j,l,nrowa
           logical(lk) upper
           ! ..
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
     
           ! test the input parameters.
     
           if (stdlib_lsame(trans,'n')) then
               nrowa = n
           else
               nrowa = k
           end if
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 1
           else if ((.not.stdlib_lsame(trans,'n')) .and.(.not.stdlib_lsame(trans,'t')) .and.(&
                     .not.stdlib_lsame(trans,'c'))) then
               info = 2
           else if (n<0) then
               info = 3
           else if (k<0) then
               info = 4
           else if (lda<max(1,nrowa)) then
               info = 7
           else if (ldc<max(1,n)) then
               info = 10
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dsyrk ',info)
               return
           end if
     
           ! quick return if possible.
     
           if ((n==0) .or. (((alpha==zero).or.(k==0)).and. (beta==one))) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               if (upper) then
                   if (beta==zero) then
                       do 20 j = 1,n
                           do 10 i = 1,j
                               c(i,j) = zero
        10                 continue
        20             continue
                   else
                       do 40 j = 1,n
                           do 30 i = 1,j
                               c(i,j) = beta*c(i,j)
        30                 continue
        40             continue
                   end if
               else
                   if (beta==zero) then
                       do 60 j = 1,n
                           do 50 i = j,n
                               c(i,j) = zero
        50                 continue
        60             continue
                   else
                       do 80 j = 1,n
                           do 70 i = j,n
                               c(i,j) = beta*c(i,j)
        70                 continue
        80             continue
                   end if
               end if
               return
           end if
     
           ! start the operations.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  c := alpha*a*a**t + beta*c.
     
               if (upper) then
                   do 130 j = 1,n
                       if (beta==zero) then
                           do 90 i = 1,j
                               c(i,j) = zero
        90                 continue
                       else if (beta/=one) then
                           do 100 i = 1,j
                               c(i,j) = beta*c(i,j)
       100                 continue
                       end if
                       do 120 l = 1,k
                           if (a(j,l)/=zero) then
                               temp = alpha*a(j,l)
                               do 110 i = 1,j
                                   c(i,j) = c(i,j) + temp*a(i,l)
       110                     continue
                           end if
       120             continue
       130         continue
               else
                   do 180 j = 1,n
                       if (beta==zero) then
                           do 140 i = j,n
                               c(i,j) = zero
       140                 continue
                       else if (beta/=one) then
                           do 150 i = j,n
                               c(i,j) = beta*c(i,j)
       150                 continue
                       end if
                       do 170 l = 1,k
                           if (a(j,l)/=zero) then
                               temp = alpha*a(j,l)
                               do 160 i = j,n
                                   c(i,j) = c(i,j) + temp*a(i,l)
       160                     continue
                           end if
       170             continue
       180         continue
               end if
           else
     
              ! form  c := alpha*a**t*a + beta*c.
     
               if (upper) then
                   do 210 j = 1,n
                       do 200 i = 1,j
                           temp = zero
                           do 190 l = 1,k
                               temp = temp + a(l,i)*a(l,j)
       190                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       200             continue
       210         continue
               else
                   do 240 j = 1,n
                       do 230 i = j,n
                           temp = zero
                           do 220 l = 1,k
                               temp = temp + a(l,i)*a(l,j)
       220                 continue
                           if (beta==zero) then
                               c(i,j) = alpha*temp
                           else
                               c(i,j) = alpha*temp + beta*c(i,j)
                           end if
       230             continue
       240         continue
               end if
           end if
     
           return
     
           ! end of stdlib_dsyrk
     
     end subroutine stdlib_dsyrk
     
     
     subroutine stdlib_dtbmv(uplo,trans,diag,n,k,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,k,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,kplus1,kx,l
           logical(lk) nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (k<0) then
               info = 5
           else if (lda< (k+1)) then
               info = 7
           else if (incx==0) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtbmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx   too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
               ! form  x := a*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 20 j = 1,n
                           if (x(j)/=zero) then
                               temp = x(j)
                               l = kplus1 - j
                               do 10 i = max(1,j-k),j - 1
                                   x(i) = x(i) + temp*a(l+i,j)
        10                     continue
                               if (nounit) x(j) = x(j)*a(kplus1,j)
                           end if
        20             continue
                   else
                       jx = kx
                       do 40 j = 1,n
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               l = kplus1 - j
                               do 30 i = max(1,j-k),j - 1
                                   x(ix) = x(ix) + temp*a(l+i,j)
                                   ix = ix + incx
        30                     continue
                               if (nounit) x(jx) = x(jx)*a(kplus1,j)
                           end if
                           jx = jx + incx
                           if (j>k) kx = kx + incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = n,1,-1
                           if (x(j)/=zero) then
                               temp = x(j)
                               l = 1 - j
                               do 50 i = min(n,j+k),j + 1,-1
                                   x(i) = x(i) + temp*a(l+i,j)
        50                     continue
                               if (nounit) x(j) = x(j)*a(1,j)
                           end if
        60             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 80 j = n,1,-1
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               l = 1 - j
                               do 70 i = min(n,j+k),j + 1,-1
                                   x(ix) = x(ix) + temp*a(l+i,j)
                                   ix = ix - incx
        70                     continue
                               if (nounit) x(jx) = x(jx)*a(1,j)
                           end if
                           jx = jx - incx
                           if ((n-j)>=k) kx = kx - incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := a**t*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 100 j = n,1,-1
                           temp = x(j)
                           l = kplus1 - j
                           if (nounit) temp = temp*a(kplus1,j)
                           do 90 i = j - 1,max(1,j-k),-1
                               temp = temp + a(l+i,j)*x(i)
        90                 continue
                           x(j) = temp
       100             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 120 j = n,1,-1
                           temp = x(jx)
                           kx = kx - incx
                           ix = kx
                           l = kplus1 - j
                           if (nounit) temp = temp*a(kplus1,j)
                           do 110 i = j - 1,max(1,j-k),-1
                               temp = temp + a(l+i,j)*x(ix)
                               ix = ix - incx
       110                 continue
                           x(jx) = temp
                           jx = jx - incx
       120             continue
                   end if
               else
                   if (incx==1) then
                       do 140 j = 1,n
                           temp = x(j)
                           l = 1 - j
                           if (nounit) temp = temp*a(1,j)
                           do 130 i = j + 1,min(n,j+k)
                               temp = temp + a(l+i,j)*x(i)
       130                 continue
                           x(j) = temp
       140             continue
                   else
                       jx = kx
                       do 160 j = 1,n
                           temp = x(jx)
                           kx = kx + incx
                           ix = kx
                           l = 1 - j
                           if (nounit) temp = temp*a(1,j)
                           do 150 i = j + 1,min(n,j+k)
                               temp = temp + a(l+i,j)*x(ix)
                               ix = ix + incx
       150                 continue
                           x(jx) = temp
                           jx = jx + incx
       160             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtbmv
     
     end subroutine stdlib_dtbmv
     
     
     subroutine stdlib_dtbsv(uplo,trans,diag,n,k,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,k,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,kplus1,kx,l
           logical(lk) nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max,min
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (k<0) then
               info = 5
           else if (lda< (k+1)) then
               info = 7
           else if (incx==0) then
               info = 9
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtbsv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed by sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := inv( a )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 20 j = n,1,-1
                           if (x(j)/=zero) then
                               l = kplus1 - j
                               if (nounit) x(j) = x(j)/a(kplus1,j)
                               temp = x(j)
                               do 10 i = j - 1,max(1,j-k),-1
                                   x(i) = x(i) - temp*a(l+i,j)
        10                     continue
                           end if
        20             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 40 j = n,1,-1
                           kx = kx - incx
                           if (x(jx)/=zero) then
                               ix = kx
                               l = kplus1 - j
                               if (nounit) x(jx) = x(jx)/a(kplus1,j)
                               temp = x(jx)
                               do 30 i = j - 1,max(1,j-k),-1
                                   x(ix) = x(ix) - temp*a(l+i,j)
                                   ix = ix - incx
        30                     continue
                           end if
                           jx = jx - incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = 1,n
                           if (x(j)/=zero) then
                               l = 1 - j
                               if (nounit) x(j) = x(j)/a(1,j)
                               temp = x(j)
                               do 50 i = j + 1,min(n,j+k)
                                   x(i) = x(i) - temp*a(l+i,j)
        50                     continue
                           end if
        60             continue
                   else
                       jx = kx
                       do 80 j = 1,n
                           kx = kx + incx
                           if (x(jx)/=zero) then
                               ix = kx
                               l = 1 - j
                               if (nounit) x(jx) = x(jx)/a(1,j)
                               temp = x(jx)
                               do 70 i = j + 1,min(n,j+k)
                                   x(ix) = x(ix) - temp*a(l+i,j)
                                   ix = ix + incx
        70                     continue
                           end if
                           jx = jx + incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := inv( a**t)*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kplus1 = k + 1
                   if (incx==1) then
                       do 100 j = 1,n
                           temp = x(j)
                           l = kplus1 - j
                           do 90 i = max(1,j-k),j - 1
                               temp = temp - a(l+i,j)*x(i)
        90                 continue
                           if (nounit) temp = temp/a(kplus1,j)
                           x(j) = temp
       100             continue
                   else
                       jx = kx
                       do 120 j = 1,n
                           temp = x(jx)
                           ix = kx
                           l = kplus1 - j
                           do 110 i = max(1,j-k),j - 1
                               temp = temp - a(l+i,j)*x(ix)
                               ix = ix + incx
       110                 continue
                           if (nounit) temp = temp/a(kplus1,j)
                           x(jx) = temp
                           jx = jx + incx
                           if (j>k) kx = kx + incx
       120             continue
                   end if
               else
                   if (incx==1) then
                       do 140 j = n,1,-1
                           temp = x(j)
                           l = 1 - j
                           do 130 i = min(n,j+k),j + 1,-1
                               temp = temp - a(l+i,j)*x(i)
       130                 continue
                           if (nounit) temp = temp/a(1,j)
                           x(j) = temp
       140             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 160 j = n,1,-1
                           temp = x(jx)
                           ix = kx
                           l = 1 - j
                           do 150 i = min(n,j+k),j + 1,-1
                               temp = temp - a(l+i,j)*x(ix)
                               ix = ix - incx
       150                 continue
                           if (nounit) temp = temp/a(1,j)
                           x(jx) = temp
                           jx = jx - incx
                           if ((n-j)>=k) kx = kx - incx
       160             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtbsv
     
     end subroutine stdlib_dtbsv
     
     
     subroutine stdlib_dtpmv(uplo,trans,diag,n,ap,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) ap(*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,k,kk,kx
           logical(lk) nounit
           ! ..
     
     
     
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (incx==0) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtpmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of ap are
           ! accessed sequentially with one pass through ap.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x:= a*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = 1
                   if (incx==1) then
                       do 20 j = 1,n
                           if (x(j)/=zero) then
                               temp = x(j)
                               k = kk
                               do 10 i = 1,j - 1
                                   x(i) = x(i) + temp*ap(k)
                                   k = k + 1
        10                     continue
                               if (nounit) x(j) = x(j)*ap(kk+j-1)
                           end if
                           kk = kk + j
        20             continue
                   else
                       jx = kx
                       do 40 j = 1,n
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 30 k = kk,kk + j - 2
                                   x(ix) = x(ix) + temp*ap(k)
                                   ix = ix + incx
        30                     continue
                               if (nounit) x(jx) = x(jx)*ap(kk+j-1)
                           end if
                           jx = jx + incx
                           kk = kk + j
        40             continue
                   end if
               else
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 60 j = n,1,-1
                           if (x(j)/=zero) then
                               temp = x(j)
                               k = kk
                               do 50 i = n,j + 1,-1
                                   x(i) = x(i) + temp*ap(k)
                                   k = k - 1
        50                     continue
                               if (nounit) x(j) = x(j)*ap(kk-n+j)
                           end if
                           kk = kk - (n-j+1)
        60             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 80 j = n,1,-1
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 70 k = kk,kk - (n- (j+1)),-1
                                   x(ix) = x(ix) + temp*ap(k)
                                   ix = ix - incx
        70                     continue
                               if (nounit) x(jx) = x(jx)*ap(kk-n+j)
                           end if
                           jx = jx - incx
                           kk = kk - (n-j+1)
        80             continue
                   end if
               end if
           else
     
              ! form  x := a**t*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 100 j = n,1,-1
                           temp = x(j)
                           if (nounit) temp = temp*ap(kk)
                           k = kk - 1
                           do 90 i = j - 1,1,-1
                               temp = temp + ap(k)*x(i)
                               k = k - 1
        90                 continue
                           x(j) = temp
                           kk = kk - j
       100             continue
                   else
                       jx = kx + (n-1)*incx
                       do 120 j = n,1,-1
                           temp = x(jx)
                           ix = jx
                           if (nounit) temp = temp*ap(kk)
                           do 110 k = kk - 1,kk - j + 1,-1
                               ix = ix - incx
                               temp = temp + ap(k)*x(ix)
       110                 continue
                           x(jx) = temp
                           jx = jx - incx
                           kk = kk - j
       120             continue
                   end if
               else
                   kk = 1
                   if (incx==1) then
                       do 140 j = 1,n
                           temp = x(j)
                           if (nounit) temp = temp*ap(kk)
                           k = kk + 1
                           do 130 i = j + 1,n
                               temp = temp + ap(k)*x(i)
                               k = k + 1
       130                 continue
                           x(j) = temp
                           kk = kk + (n-j+1)
       140             continue
                   else
                       jx = kx
                       do 160 j = 1,n
                           temp = x(jx)
                           ix = jx
                           if (nounit) temp = temp*ap(kk)
                           do 150 k = kk + 1,kk + n - j
                               ix = ix + incx
                               temp = temp + ap(k)*x(ix)
       150                 continue
                           x(jx) = temp
                           jx = jx + incx
                           kk = kk + (n-j+1)
       160             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtpmv
     
     end subroutine stdlib_dtpmv
     
     
     subroutine stdlib_dtpsv(uplo,trans,diag,n,ap,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) ap(*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,k,kk,kx
           logical(lk) nounit
           ! ..
     
     
     
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (incx==0) then
               info = 7
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtpsv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of ap are
           ! accessed sequentially with one pass through ap.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := inv( a )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 20 j = n,1,-1
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/ap(kk)
                               temp = x(j)
                               k = kk - 1
                               do 10 i = j - 1,1,-1
                                   x(i) = x(i) - temp*ap(k)
                                   k = k - 1
        10                     continue
                           end if
                           kk = kk - j
        20             continue
                   else
                       jx = kx + (n-1)*incx
                       do 40 j = n,1,-1
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/ap(kk)
                               temp = x(jx)
                               ix = jx
                               do 30 k = kk - 1,kk - j + 1,-1
                                   ix = ix - incx
                                   x(ix) = x(ix) - temp*ap(k)
        30                     continue
                           end if
                           jx = jx - incx
                           kk = kk - j
        40             continue
                   end if
               else
                   kk = 1
                   if (incx==1) then
                       do 60 j = 1,n
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/ap(kk)
                               temp = x(j)
                               k = kk + 1
                               do 50 i = j + 1,n
                                   x(i) = x(i) - temp*ap(k)
                                   k = k + 1
        50                     continue
                           end if
                           kk = kk + (n-j+1)
        60             continue
                   else
                       jx = kx
                       do 80 j = 1,n
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/ap(kk)
                               temp = x(jx)
                               ix = jx
                               do 70 k = kk + 1,kk + n - j
                                   ix = ix + incx
                                   x(ix) = x(ix) - temp*ap(k)
        70                     continue
                           end if
                           jx = jx + incx
                           kk = kk + (n-j+1)
        80             continue
                   end if
               end if
           else
     
              ! form  x := inv( a**t )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   kk = 1
                   if (incx==1) then
                       do 100 j = 1,n
                           temp = x(j)
                           k = kk
                           do 90 i = 1,j - 1
                               temp = temp - ap(k)*x(i)
                               k = k + 1
        90                 continue
                           if (nounit) temp = temp/ap(kk+j-1)
                           x(j) = temp
                           kk = kk + j
       100             continue
                   else
                       jx = kx
                       do 120 j = 1,n
                           temp = x(jx)
                           ix = kx
                           do 110 k = kk,kk + j - 2
                               temp = temp - ap(k)*x(ix)
                               ix = ix + incx
       110                 continue
                           if (nounit) temp = temp/ap(kk+j-1)
                           x(jx) = temp
                           jx = jx + incx
                           kk = kk + j
       120             continue
                   end if
               else
                   kk = (n* (n+1))/2
                   if (incx==1) then
                       do 140 j = n,1,-1
                           temp = x(j)
                           k = kk
                           do 130 i = n,j + 1,-1
                               temp = temp - ap(k)*x(i)
                               k = k - 1
       130                 continue
                           if (nounit) temp = temp/ap(kk-n+j)
                           x(j) = temp
                           kk = kk - (n-j+1)
       140             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 160 j = n,1,-1
                           temp = x(jx)
                           ix = kx
                           do 150 k = kk,kk - (n- (j+1)),-1
                               temp = temp - ap(k)*x(ix)
                               ix = ix - incx
       150                 continue
                           if (nounit) temp = temp/ap(kk-n+j)
                           x(jx) = temp
                           jx = jx - incx
                           kk = kk - (n-j+1)
       160             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtpsv
     
     end subroutine stdlib_dtpsv
     
     
     subroutine stdlib_dtrmm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) lda,ldb,m,n
           character diag,side,transa,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),b(ldb,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,j,k,nrowa
           logical(lk) lside,nounit,upper
           ! ..
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
     
           ! test the input parameters.
     
           lside = stdlib_lsame(side,'l')
           if (lside) then
               nrowa = m
           else
               nrowa = n
           end if
           nounit = stdlib_lsame(diag,'n')
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.lside) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if ((.not.stdlib_lsame(transa,'n')) .and.(.not.stdlib_lsame(transa,'t')) .and.(&
                     .not.stdlib_lsame(transa,'c'))) then
               info = 3
           else if ((.not.stdlib_lsame(diag,'u')) .and. (.not.stdlib_lsame(diag,'n'))) &
                     then
               info = 4
           else if (m<0) then
               info = 5
           else if (n<0) then
               info = 6
           else if (lda<max(1,nrowa)) then
               info = 9
           else if (ldb<max(1,m)) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtrmm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (m==0 .or. n==0) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               do 20 j = 1,n
                   do 10 i = 1,m
                       b(i,j) = zero
        10         continue
        20     continue
               return
           end if
     
           ! start the operations.
     
           if (lside) then
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*a*b.
     
                   if (upper) then
                       do 50 j = 1,n
                           do 40 k = 1,m
                               if (b(k,j)/=zero) then
                                   temp = alpha*b(k,j)
                                   do 30 i = 1,k - 1
                                       b(i,j) = b(i,j) + temp*a(i,k)
        30                         continue
                                   if (nounit) temp = temp*a(k,k)
                                   b(k,j) = temp
                               end if
        40                 continue
        50             continue
                   else
                       do 80 j = 1,n
                           do 70 k = m,1,-1
                               if (b(k,j)/=zero) then
                                   temp = alpha*b(k,j)
                                   b(k,j) = temp
                                   if (nounit) b(k,j) = b(k,j)*a(k,k)
                                   do 60 i = k + 1,m
                                       b(i,j) = b(i,j) + temp*a(i,k)
        60                         continue
                               end if
        70                 continue
        80             continue
                   end if
               else
     
                 ! form  b := alpha*a**t*b.
     
                   if (upper) then
                       do 110 j = 1,n
                           do 100 i = m,1,-1
                               temp = b(i,j)
                               if (nounit) temp = temp*a(i,i)
                               do 90 k = 1,i - 1
                                   temp = temp + a(k,i)*b(k,j)
        90                     continue
                               b(i,j) = alpha*temp
       100                 continue
       110             continue
                   else
                       do 140 j = 1,n
                           do 130 i = 1,m
                               temp = b(i,j)
                               if (nounit) temp = temp*a(i,i)
                               do 120 k = i + 1,m
                                   temp = temp + a(k,i)*b(k,j)
       120                     continue
                               b(i,j) = alpha*temp
       130                 continue
       140             continue
                   end if
               end if
           else
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*b*a.
     
                   if (upper) then
                       do 180 j = n,1,-1
                           temp = alpha
                           if (nounit) temp = temp*a(j,j)
                           do 150 i = 1,m
                               b(i,j) = temp*b(i,j)
       150                 continue
                           do 170 k = 1,j - 1
                               if (a(k,j)/=zero) then
                                   temp = alpha*a(k,j)
                                   do 160 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       160                         continue
                               end if
       170                 continue
       180             continue
                   else
                       do 220 j = 1,n
                           temp = alpha
                           if (nounit) temp = temp*a(j,j)
                           do 190 i = 1,m
                               b(i,j) = temp*b(i,j)
       190                 continue
                           do 210 k = j + 1,n
                               if (a(k,j)/=zero) then
                                   temp = alpha*a(k,j)
                                   do 200 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       200                         continue
                               end if
       210                 continue
       220             continue
                   end if
               else
     
                 ! form  b := alpha*b*a**t.
     
                   if (upper) then
                       do 260 k = 1,n
                           do 240 j = 1,k - 1
                               if (a(j,k)/=zero) then
                                   temp = alpha*a(j,k)
                                   do 230 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       230                         continue
                               end if
       240                 continue
                           temp = alpha
                           if (nounit) temp = temp*a(k,k)
                           if (temp/=one) then
                               do 250 i = 1,m
                                   b(i,k) = temp*b(i,k)
       250                     continue
                           end if
       260             continue
                   else
                       do 300 k = n,1,-1
                           do 280 j = k + 1,n
                               if (a(j,k)/=zero) then
                                   temp = alpha*a(j,k)
                                   do 270 i = 1,m
                                       b(i,j) = b(i,j) + temp*b(i,k)
       270                         continue
                               end if
       280                 continue
                           temp = alpha
                           if (nounit) temp = temp*a(k,k)
                           if (temp/=one) then
                               do 290 i = 1,m
                                   b(i,k) = temp*b(i,k)
       290                     continue
                           end if
       300             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtrmm
     
     end subroutine stdlib_dtrmm
     
     
     subroutine stdlib_dtrmv(uplo,trans,diag,n,a,lda,x,incx)
     
        ! -- reference blas level2 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,kx
           logical(lk) nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,n)) then
               info = 6
           else if (incx==0) then
               info = 8
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtrmv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := a*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 20 j = 1,n
                           if (x(j)/=zero) then
                               temp = x(j)
                               do 10 i = 1,j - 1
                                   x(i) = x(i) + temp*a(i,j)
        10                     continue
                               if (nounit) x(j) = x(j)*a(j,j)
                           end if
        20             continue
                   else
                       jx = kx
                       do 40 j = 1,n
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 30 i = 1,j - 1
                                   x(ix) = x(ix) + temp*a(i,j)
                                   ix = ix + incx
        30                     continue
                               if (nounit) x(jx) = x(jx)*a(j,j)
                           end if
                           jx = jx + incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = n,1,-1
                           if (x(j)/=zero) then
                               temp = x(j)
                               do 50 i = n,j + 1,-1
                                   x(i) = x(i) + temp*a(i,j)
        50                     continue
                               if (nounit) x(j) = x(j)*a(j,j)
                           end if
        60             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 80 j = n,1,-1
                           if (x(jx)/=zero) then
                               temp = x(jx)
                               ix = kx
                               do 70 i = n,j + 1,-1
                                   x(ix) = x(ix) + temp*a(i,j)
                                   ix = ix - incx
        70                     continue
                               if (nounit) x(jx) = x(jx)*a(j,j)
                           end if
                           jx = jx - incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := a**t*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 100 j = n,1,-1
                           temp = x(j)
                           if (nounit) temp = temp*a(j,j)
                           do 90 i = j - 1,1,-1
                               temp = temp + a(i,j)*x(i)
        90                 continue
                           x(j) = temp
       100             continue
                   else
                       jx = kx + (n-1)*incx
                       do 120 j = n,1,-1
                           temp = x(jx)
                           ix = jx
                           if (nounit) temp = temp*a(j,j)
                           do 110 i = j - 1,1,-1
                               ix = ix - incx
                               temp = temp + a(i,j)*x(ix)
       110                 continue
                           x(jx) = temp
                           jx = jx - incx
       120             continue
                   end if
               else
                   if (incx==1) then
                       do 140 j = 1,n
                           temp = x(j)
                           if (nounit) temp = temp*a(j,j)
                           do 130 i = j + 1,n
                               temp = temp + a(i,j)*x(i)
       130                 continue
                           x(j) = temp
       140             continue
                   else
                       jx = kx
                       do 160 j = 1,n
                           temp = x(jx)
                           ix = jx
                           if (nounit) temp = temp*a(j,j)
                           do 150 i = j + 1,n
                               ix = ix + incx
                               temp = temp + a(i,j)*x(ix)
       150                 continue
                           x(jx) = temp
                           jx = jx + incx
       160             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtrmv
     
     end subroutine stdlib_dtrmv
     
     
     subroutine stdlib_dtrsm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
     
        ! -- reference blas level3 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           real(dp) alpha
           integer(int32) lda,ldb,m,n
           character diag,side,transa,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),b(ldb,*)
           ! ..
     
        ! =====================================================================
     
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,j,k,nrowa
           logical(lk) lside,nounit,upper
           ! ..
           ! .. parameters ..
           real(dp) one,zero
           parameter (one=1.0_dp,zero=0.0_dp)
           ! ..
     
           ! test the input parameters.
     
           lside = stdlib_lsame(side,'l')
           if (lside) then
               nrowa = m
           else
               nrowa = n
           end if
           nounit = stdlib_lsame(diag,'n')
           upper = stdlib_lsame(uplo,'u')
     
           info = 0
           if ((.not.lside) .and. (.not.stdlib_lsame(side,'r'))) then
               info = 1
           else if ((.not.upper) .and. (.not.stdlib_lsame(uplo,'l'))) then
               info = 2
           else if ((.not.stdlib_lsame(transa,'n')) .and.(.not.stdlib_lsame(transa,'t')) .and.(&
                     .not.stdlib_lsame(transa,'c'))) then
               info = 3
           else if ((.not.stdlib_lsame(diag,'u')) .and. (.not.stdlib_lsame(diag,'n'))) &
                     then
               info = 4
           else if (m<0) then
               info = 5
           else if (n<0) then
               info = 6
           else if (lda<max(1,nrowa)) then
               info = 9
           else if (ldb<max(1,m)) then
               info = 11
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtrsm ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (m==0 .or. n==0) return
     
           ! and when  alpha.eq.zero.
     
           if (alpha==zero) then
               do 20 j = 1,n
                   do 10 i = 1,m
                       b(i,j) = zero
        10         continue
        20     continue
               return
           end if
     
           ! start the operations.
     
           if (lside) then
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*inv( a )*b.
     
                   if (upper) then
                       do 60 j = 1,n
                           if (alpha/=one) then
                               do 30 i = 1,m
                                   b(i,j) = alpha*b(i,j)
        30                     continue
                           end if
                           do 50 k = m,1,-1
                               if (b(k,j)/=zero) then
                                   if (nounit) b(k,j) = b(k,j)/a(k,k)
                                   do 40 i = 1,k - 1
                                       b(i,j) = b(i,j) - b(k,j)*a(i,k)
        40                         continue
                               end if
        50                 continue
        60             continue
                   else
                       do 100 j = 1,n
                           if (alpha/=one) then
                               do 70 i = 1,m
                                   b(i,j) = alpha*b(i,j)
        70                     continue
                           end if
                           do 90 k = 1,m
                               if (b(k,j)/=zero) then
                                   if (nounit) b(k,j) = b(k,j)/a(k,k)
                                   do 80 i = k + 1,m
                                       b(i,j) = b(i,j) - b(k,j)*a(i,k)
        80                         continue
                               end if
        90                 continue
       100             continue
                   end if
               else
     
                 ! form  b := alpha*inv( a**t )*b.
     
                   if (upper) then
                       do 130 j = 1,n
                           do 120 i = 1,m
                               temp = alpha*b(i,j)
                               do 110 k = 1,i - 1
                                   temp = temp - a(k,i)*b(k,j)
       110                     continue
                               if (nounit) temp = temp/a(i,i)
                               b(i,j) = temp
       120                 continue
       130             continue
                   else
                       do 160 j = 1,n
                           do 150 i = m,1,-1
                               temp = alpha*b(i,j)
                               do 140 k = i + 1,m
                                   temp = temp - a(k,i)*b(k,j)
       140                     continue
                               if (nounit) temp = temp/a(i,i)
                               b(i,j) = temp
       150                 continue
       160             continue
                   end if
               end if
           else
               if (stdlib_lsame(transa,'n')) then
     
                 ! form  b := alpha*b*inv( a ).
     
                   if (upper) then
                       do 210 j = 1,n
                           if (alpha/=one) then
                               do 170 i = 1,m
                                   b(i,j) = alpha*b(i,j)
       170                     continue
                           end if
                           do 190 k = 1,j - 1
                               if (a(k,j)/=zero) then
                                   do 180 i = 1,m
                                       b(i,j) = b(i,j) - a(k,j)*b(i,k)
       180                         continue
                               end if
       190                 continue
                           if (nounit) then
                               temp = one/a(j,j)
                               do 200 i = 1,m
                                   b(i,j) = temp*b(i,j)
       200                     continue
                           end if
       210             continue
                   else
                       do 260 j = n,1,-1
                           if (alpha/=one) then
                               do 220 i = 1,m
                                   b(i,j) = alpha*b(i,j)
       220                     continue
                           end if
                           do 240 k = j + 1,n
                               if (a(k,j)/=zero) then
                                   do 230 i = 1,m
                                       b(i,j) = b(i,j) - a(k,j)*b(i,k)
       230                         continue
                               end if
       240                 continue
                           if (nounit) then
                               temp = one/a(j,j)
                               do 250 i = 1,m
                                   b(i,j) = temp*b(i,j)
       250                     continue
                           end if
       260             continue
                   end if
               else
     
                 ! form  b := alpha*b*inv( a**t ).
     
                   if (upper) then
                       do 310 k = n,1,-1
                           if (nounit) then
                               temp = one/a(k,k)
                               do 270 i = 1,m
                                   b(i,k) = temp*b(i,k)
       270                     continue
                           end if
                           do 290 j = 1,k - 1
                               if (a(j,k)/=zero) then
                                   temp = a(j,k)
                                   do 280 i = 1,m
                                       b(i,j) = b(i,j) - temp*b(i,k)
       280                         continue
                               end if
       290                 continue
                           if (alpha/=one) then
                               do 300 i = 1,m
                                   b(i,k) = alpha*b(i,k)
       300                     continue
                           end if
       310             continue
                   else
                       do 360 k = 1,n
                           if (nounit) then
                               temp = one/a(k,k)
                               do 320 i = 1,m
                                   b(i,k) = temp*b(i,k)
       320                     continue
                           end if
                           do 340 j = k + 1,n
                               if (a(j,k)/=zero) then
                                   temp = a(j,k)
                                   do 330 i = 1,m
                                       b(i,j) = b(i,j) - temp*b(i,k)
       330                         continue
                               end if
       340                 continue
                           if (alpha/=one) then
                               do 350 i = 1,m
                                   b(i,k) = alpha*b(i,k)
       350                     continue
                           end if
       360             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtrsm
     
     end subroutine stdlib_dtrsm
     
     
     subroutine stdlib_dtrsv(uplo,trans,diag,n,a,lda,x,incx)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,lda,n
           character diag,trans,uplo
           ! ..
           ! .. array arguments ..
           real(dp) a(lda,*),x(*)
           ! ..
     
        ! =====================================================================
     
           ! .. parameters ..
           real(dp) zero
           parameter (zero=0.0_dp)
           ! ..
           ! .. local scalars ..
           real(dp) temp
           integer(int32) i,info,ix,j,jx,kx
           logical(lk) nounit
           ! ..
     
     
     
           ! .. intrinsic functions ..
           intrinsic max
           ! ..
     
           ! test the input parameters.
     
           info = 0
           if (.not.stdlib_lsame(uplo,'u') .and. .not.stdlib_lsame(uplo,'l')) then
               info = 1
           else if (.not.stdlib_lsame(trans,'n') .and. .not.stdlib_lsame(trans,'t') &
                     .and..not.stdlib_lsame(trans,'c')) then
               info = 2
           else if (.not.stdlib_lsame(diag,'u') .and. .not.stdlib_lsame(diag,'n')) then
               info = 3
           else if (n<0) then
               info = 4
           else if (lda<max(1,n)) then
               info = 6
           else if (incx==0) then
               info = 8
           end if
           if (info/=0) then
               call stdlib_xerbla('stdlib_dtrsv ',info)
               return
           end if
     
           ! quick return if possible.
     
           if (n==0) return
     
           nounit = stdlib_lsame(diag,'n')
     
           ! set up the start point in x if the increment is not unity. this
           ! will be  ( n - 1 )*incx  too small for descending loops.
     
           if (incx<=0) then
               kx = 1 - (n-1)*incx
           else if (incx/=1) then
               kx = 1
           end if
     
           ! start the operations. in this version the elements of a are
           ! accessed sequentially with one pass through a.
     
           if (stdlib_lsame(trans,'n')) then
     
              ! form  x := inv( a )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 20 j = n,1,-1
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/a(j,j)
                               temp = x(j)
                               do 10 i = j - 1,1,-1
                                   x(i) = x(i) - temp*a(i,j)
        10                     continue
                           end if
        20             continue
                   else
                       jx = kx + (n-1)*incx
                       do 40 j = n,1,-1
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/a(j,j)
                               temp = x(jx)
                               ix = jx
                               do 30 i = j - 1,1,-1
                                   ix = ix - incx
                                   x(ix) = x(ix) - temp*a(i,j)
        30                     continue
                           end if
                           jx = jx - incx
        40             continue
                   end if
               else
                   if (incx==1) then
                       do 60 j = 1,n
                           if (x(j)/=zero) then
                               if (nounit) x(j) = x(j)/a(j,j)
                               temp = x(j)
                               do 50 i = j + 1,n
                                   x(i) = x(i) - temp*a(i,j)
        50                     continue
                           end if
        60             continue
                   else
                       jx = kx
                       do 80 j = 1,n
                           if (x(jx)/=zero) then
                               if (nounit) x(jx) = x(jx)/a(j,j)
                               temp = x(jx)
                               ix = jx
                               do 70 i = j + 1,n
                                   ix = ix + incx
                                   x(ix) = x(ix) - temp*a(i,j)
        70                     continue
                           end if
                           jx = jx + incx
        80             continue
                   end if
               end if
           else
     
              ! form  x := inv( a**t )*x.
     
               if (stdlib_lsame(uplo,'u')) then
                   if (incx==1) then
                       do 100 j = 1,n
                           temp = x(j)
                           do 90 i = 1,j - 1
                               temp = temp - a(i,j)*x(i)
        90                 continue
                           if (nounit) temp = temp/a(j,j)
                           x(j) = temp
       100             continue
                   else
                       jx = kx
                       do 120 j = 1,n
                           temp = x(jx)
                           ix = kx
                           do 110 i = 1,j - 1
                               temp = temp - a(i,j)*x(ix)
                               ix = ix + incx
       110                 continue
                           if (nounit) temp = temp/a(j,j)
                           x(jx) = temp
                           jx = jx + incx
       120             continue
                   end if
               else
                   if (incx==1) then
                       do 140 j = n,1,-1
                           temp = x(j)
                           do 130 i = n,j + 1,-1
                               temp = temp - a(i,j)*x(i)
       130                 continue
                           if (nounit) temp = temp/a(j,j)
                           x(j) = temp
       140             continue
                   else
                       kx = kx + (n-1)*incx
                       jx = kx
                       do 160 j = n,1,-1
                           temp = x(jx)
                           ix = kx
                           do 150 i = n,j + 1,-1
                               temp = temp - a(i,j)*x(ix)
                               ix = ix - incx
       150                 continue
                           if (nounit) temp = temp/a(j,j)
                           x(jx) = temp
                           jx = jx - incx
       160             continue
                   end if
               end if
           end if
     
           return
     
           ! end of stdlib_dtrsv
     
     end subroutine stdlib_dtrsv
     
     
     real(dp) function stdlib_dzasum(n,zx,incx)
     
        ! -- reference blas level1 routine --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
     
           ! .. scalar arguments ..
           integer(int32) incx,n
           ! ..
           ! .. array arguments ..
           complex(dp) zx(*)
           ! ..
     
        ! =====================================================================
     
           ! .. local scalars ..
           real(dp) stemp
           integer(int32) i,nincx
           ! ..
     
     
           stdlib_dzasum = 0.0d0
           stemp = 0.0d0
           if (n<=0 .or. incx<=0) return
           if (incx==1) then
     
              ! code for increment equal to 1
     
              do i = 1,n
                 stemp = stemp + stdlib_dcabs1(zx(i))
              end do
           else
     
              ! code for increment not equal to 1
     
              nincx = n*incx
              do i = 1,nincx,incx
                 stemp = stemp + stdlib_dcabs1(zx(i))
              end do
           end if
           stdlib_dzasum = stemp
           return
     
           ! end of stdlib_dzasum
     
     end function stdlib_dzasum
     
     
     function stdlib_dznrm2( n, x, incx )
        integer, parameter :: wp = kind(1.d0)
        real(dp) :: stdlib_dznrm2
     
        ! -- reference blas level1 routine (version 3.9.1) --
        ! -- reference blas is a software package provided by univ. of tennessee,    --
        ! -- univ. of california berkeley, univ. of colorado denver and nag ltd..--
           ! march 2021
     
        ! .. constants ..
        real(dp), parameter ::dzero = 0.0_dp
        real(dp), parameter :: done  = 1.0_dp
        real(dp), parameter :: maxn = huge(0.0_dp)
        ! ..
        ! .. blue's scaling constants ..
     real(dp), parameter :: tsml = real(radix(0._dp), wp)**ceiling(       (minexponent(0._dp) - 1)&
                * 0.5_dp)
     real(dp), parameter :: tbig = real(radix(0._dp), wp)**floor(       (maxexponent(0._dp) - &
               digits(0._dp) + 1) * 0.5_dp)
     real(dp), parameter :: ssml = real(radix(0._dp), wp)**( - floor(       (minexponent(0._dp) - &
               digits(0._dp)) * 0.5_dp))
     real(dp), parameter :: sbig = real(radix(0._dp), wp)**( - ceiling(       (maxexponent(0._dp) &
               + digits(0._dp) - 1) * 0.5_dp))
        ! ..
        ! .. scalar arguments ..
        integer :: incx, n
        ! ..
        ! .. array arguments ..
        complex(dp) :: x(*)
        ! ..
        ! .. local scalars ..
        integer :: i, ix
        logical :: notbig
        real(dp) :: abig, amed, asml, ax, scl, sumsq, ymax, ymin
     
        ! quick return if possible
     
        stdlib_dznrm2 =dzero
        if( n <= 0 ) return
     
        scl = done
        sumsq =dzero
     
        ! compute the sum of squares in 3 accumulators:
           ! abig -- sums of squares scaled down to avoid overflow
           ! asml -- sums of squares scaled up to avoid underflow
           ! amed -- sums of squares that do not require scaling
        ! the thresholds and multipliers are
           ! tbig -- values bigger than this are scaled down by sbig
           ! tsml -- values smaller than this are scaled up by ssml
     
        notbig = .true.
        asml =dzero
        amed =dzero
        abig =dzero
        ix = 1
        if( incx < 0 ) ix = 1 - (n-1)*incx
        do i = 1, n
           ax = abs(real(x(ix)))
           if (ax > tbig) then
              abig = abig + (ax*sbig)**2
              notbig = .false.
           else if (ax < tsml) then
              if (notbig) asml = asml + (ax*ssml)**2
           else
              amed = amed + ax**2
           end if
           ax = abs(aimag(x(ix)))
           if (ax > tbig) then
              abig = abig + (ax*sbig)**2
              notbig = .false.
           else if (ax < tsml) then
              if (notbig) asml = asml + (ax*ssml)**2
           else
              amed = amed + ax**2
           end if
           ix = ix + incx
        end do
     
        ! combine abig and amed or amed and asml if more than done
        ! accumulator was used.
     
        if (abig >dzero) then
     
           ! combine abig and amed if abig > 0.
     
           if ( (amed >dzero) .or. (amed > maxn) .or. (amed /= amed) ) then
              abig = abig + (amed*sbig)*sbig
           end if
           scl = done / sbig
           sumsq = abig
        else if (asml >dzero) then
     
           ! combine amed and asml if asml > 0.
     
           if ( (amed >dzero) .or. (amed > maxn) .or. (amed /= amed) ) then
              amed = sqrt(amed)
              asml = sqrt(asml) / ssml
              if (asml > amed) then
                 ymin = amed
                 ymax = asml
              else
                 ymin = asml
                 ymax = amed
              end if
              scl = done
              sumsq = ymax**2*( done + (ymin/ymax)**2 )
           else
              scl = done / ssml
              sumsq = asml
           end if
        else
     
           ! otherwise all values are mid-range
     
           scl = done
           sumsq = amed
        end if
        stdlib_dznrm2 = scl*sqrt( sumsq )
        return
     end function stdlib_dznrm2



end module stdlib_linalg_blas_d
