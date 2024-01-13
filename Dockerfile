FROM archlinux:base-20240101.0.204074 as build
WORKDIR /build
ENV HUGO_ENV="production"
RUN pacman -Syyu --noconfirm gcc-libs hugo
COPY hugo /build 
RUN hugo -d /link-page

FROM httpd:2.4.58-alpine3.19
COPY --from=build /link-page/ /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
