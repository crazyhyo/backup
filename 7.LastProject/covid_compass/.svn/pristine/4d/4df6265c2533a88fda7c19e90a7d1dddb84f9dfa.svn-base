<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/x-handlebars-template" id="pcr-template">
{{#each .}}
	<tr class="each-pcr-element">
		<td class="sorting_1" tabindex="0">{{prettifyDate inputYmd}}</td>
		<td>{{mberNm}}</td>
		<td>{{inputCnt}}</td>
	</tr>
{{/each}}
</script>

<div class="card-header ui-sortable-handle">
					<tr role="row">
						<th tabindex="0" aria-controls="example2" rowspan="1"
							style="text-align: center;" colspan="1" aria-label="">
							<div class="col-md-8" style="font-size: 16px;">
								<b>PCR키트  <span id="kitCount"></span>개</b>
							</div>
							<div class="card-tools ">
								<button type="button" class="btn btn-tool"
									onclick="OpenWindow('pcrKitForm', '키트등록', 800,615)">
									<i class="fas fa-plus"></i>
								</button>

							</div>
						</th>
					</tr>

				</div>
				<!-- /.card-header -->
				<div class="card-body" style="padding: 0px;">
					<div class="table-responsive">
						<table class="table m-0" style="text-align: center;">
							<thead>
								<tr role="row">
									<th tabindex="0" aria-controls="example2" rowspan="1" style="text-align: center;" colspan="1" class="col-md-4" aria-label="Browser: activate to sort column ascending">등록일</th>
									<th tabindex="0" aria-controls="example2" rowspan="1" style="text-align: center;" colspan="1" class="col-md-4" aria-label="Browser: activate to sort column ascending">이름</th>
									<th tabindex="0" aria-controls="example2" rowspan="1" style="text-align: center;" colspan="1" class="col-md-4" aria-label="Platform(s): activate to sort column ascending">수량</th>
								</tr>
							</thead>
							<tbody id="pcr-table-tbody">
								<tr class="each-pcr-element">
									<td colspan="3">페이지 로딩중입니다.</td>
								</tr>
							</tbody>
						</table>
					</div>

				</div>
				<!-- /.card-body -->