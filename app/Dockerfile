FROM python@sha256:0b23cfb7425d065008b778022a17b1551c82f8b4866ee5a7a200084b7e2eafbf AS buildtime

WORKDIR /app

COPY . .


FROM python@sha256:0b23cfb7425d065008b778022a17b1551c82f8b4866ee5a7a200084b7e2eafbf AS runtime

WORKDIR /app 

COPY --from=buildtime /app/index.html /app/index.html

RUN groupadd --gid 1000 my_group && useradd --uid 1000 --gid 1000 -m my_user 

RUN chown -R my_user:my_group /app

USER my_user 

EXPOSE 3000

CMD ["python3", "-m", "http.server", "3000"]

