FROM redis:5

RUN set -x && \
	apt update

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN set -x && \
	apt -y install gpg && \
	chmod +x /tini && \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
	gpg --verify /tini.asc


FROM redis:5

COPY --from=0 /tini /tini

ENTRYPOINT ["/tini", "--", "/root/boot.sh"]

COPY fs /

CMD ["cluster"]

