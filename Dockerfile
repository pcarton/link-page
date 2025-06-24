FROM nixos/nix:2.29.1 as build

WORKDIR /build
ENV HUGO_ENV="production"

RUN nix-channel --update
RUN nix-env -iA nixpkgs.hugo

COPY hugo /build
RUN hugo -d /link-page

FROM httpd:2.4.63-alpine
COPY --from=build /link-page/ /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
RUN adduser -D httpd
RUN chown -R httpd /usr/local/apache2/
USER httpd
