FROM test-base-image:tmp AS base_image

FROM base_image AS release

ENV PATH /root/.local/bin:$PATH

ENTRYPOINT ["python3"]
CMD ["-m", "unittest", "discover"]

COPY --from=base_image /root/.local /root/.local

WORKDIR /tmp/test

