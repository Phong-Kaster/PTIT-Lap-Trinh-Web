/**
 * 
 */


/**************************************************
 * @author Phong
 * Step 1: lang nghe su kien click nut btn-search-comment
 * Step 2: gui mot AJAX POST request ve de la ra cac ket qua phu hop
 * Step 3: xoa sach cac the <tr> co tren man hinh
 * Step 4: lan luot chen html voi du lieu da nhan duoc vao
 * Step 5: tuy thuoc vao comment_status se di kem voi `status` va `option` tuong ung
 * Step 6: chen lan luot tung doi tuong vao <tbody>
 * @return in ra cac comment neu su dung thanh tim kiem
 **************************************************/
let searchByKeyword = ()=>{
	/*Step 1 */
	$(".btn-search-comment").unbind("click").on("click", function(){
		let keyword = $("#keyword").val();
		
		
		/*Step 2 */
		$.ajax({
			url: `${URL}comment.htm`,
			type: "post",
			data:{ keyword: keyword},
			dataType: 'json',
			success: function(data)
			{
				/*Step 3 */
				$("#commentBody").empty();
				
				
				/*Step 4 */
				data.forEach( (element)=>{
					let status ;
					let option ;
					
					
					
					/*Step 5 */
					if( element.comment_status == 'approved' )
					{
						status = `<span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-success-light text-success">${ element.comment_status }</span>`
						option = `<button type="button" class="btn-option btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                               		Phản hồi
                               </button>
                               
                               <button type="button" class="btn-option btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                           			Thùng rác
                           		</button>`;
					}
					if( element.comment_status == 'pending' )
					{
						status = `<span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-info-light text-info">${ element.comment_status }</span>`;
						option = `<button type="button" class="btn-option btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
		                                Chấp thuận
                                   </button>
                                   
                                   <button type="button" class="btn-option btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                               			Thùng rác
                               	   </button>`;
					}
					if( element.comment_status == 'trash' )
					{
						status = `<span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-danger-light text-danger">${ element.comment_status }</span>`;
						option = `<button type="button" class="btn-option btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip" title="Xóa vĩnh viễn bình luận này">
                                   		Phục hồi
                                   </button>
						
									<button type="button" class="btn-option btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip" title="Xóa vĩnh viễn bình luận này">
                                   		Xoá
                                   </button>`;
					}
					/*Step 6 */
					$("#commentBody").append(`
							<tr>
                                 <td class="fw-semibold fs-sm">
                                    <a href="${URL }/comment.htm?commentAuthor=${element.comment_author}">${ element.comment_author }</a>
                                 </td>
                                 
                                 <td class="fw-semibold fs-sm">
                                 	<div class="commentcontent">
                                 		${ element.comment_content } 
                                 		</br>
                                    	<div class="btn-group">
                                    		<!-- IN RA CAC NUT HANH DONG TUY THEO TRANG THAI COMMENT -->
                                    		${ option }
	                                    </div>
                                    </div>
                                    
                                 </td>
                                 
                                 <td class="fs-sm"><a href="${CLIENTURL }article/${element.post.id }/${element.post.post_slug}.htm">${ element.post.title }</a></em></td>
                                 <td>
									<format:formatDate value="${element.comment_date }" pattern="dd-MM-yyyy hh:mm aa" />
                                 </td>
                                 <td class="text-center">
	                              		${status}
                                 </td>
                              </tr>
					`);
				})
			}
		})
	});
}


/**************************************************
 * @author Phong
 * @return xu ly viec xoa comment
 **************************************************/
let removeComment = ()=>{
	$(".btn-remove-comment").unbind("click").on("click", function(){
		let id = $(this).data("uid");
		
		/*Step 1*/
        Swal.fire({
            title: 'Bạn có chắc chắn xóa không ?',
            text: "Bạn sẽ không thể khôi phục hành động này!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			  ajaxRemoveComment(id);
				
            }
          })
	});
}

/**************************************************
 * @author Phong
 * Step 1: gui ajax va hien thong bao thanh cong
 * Step 2: xoa doi tuong tren bang
 * Step 3: cap nhat so luong comment rac
 * Step 4: cap nhat tong so luong comment
 * @return ajax xoa comment
 **************************************************/
let ajaxRemoveComment = (id) =>{
	/*Step 1 */
	$.ajax({ 
		type: "GET",
		url: `${URL}remove-comment.htm`,
		data: { id: id},
		success: function(data){
			if( data == "success")
			{
				Swal.fire(
                'Hoàn tất!',
                'Thao tác thành công',
                'success'
              );
				/*Step 2 */
				$("#commentBody").find(`tr[data-uid = ${id}]`).remove();
				
				/*Step 3 */
				let quantityTrashComment = $("#quantityTrashComment").text();
				let leftQuantityTrashComment = quantityTrashComment - 1;
				$("#quantityTrashComment").text(leftQuantityTrashComment);
				
				/*Step 4 */
				let quantityTotalComment = $("#quantityTotalComment").text();
				let leftQuantityTotalComment = quantityTotalComment - 1;
				$("#quantityTotalComment").text(leftQuantityTotalComment);
				
			}
			/*IN THONG BAO NEU THAT BAI */
			else
			{
				Swal.fire(
			      'Thất bại !',
			      'Thao tác xảy ra sự cố',
			      'error'
			    );
			}
		}
	})
}



/**************************************************
 * @author Phong
 * @return xu ly viec khoi phuc comment rac thanh approved
 **************************************************/
let restoreComment = ()=>{
	$(".btn-restore-comment").unbind("click").on("click", function(){
		let id = $(this).data("uid");
		/*Step 1*/
        Swal.fire({
            title: 'Bạn có chắc chắn muốn khôi phục không ?',
            text: "Bạn có thể chỉnh lại trạng thái ngay khi thao tác kết thúc!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			  ajaxRestoreComment(id);
				
            }
          })
	});
}



/**************************************************
 * @author Phong
 * Step 1: gui ajax
 * Step 2a: thay the thanh trang thai thanh approved
 * Step 2b: thay the bang 2 nut khi comment o trang thai approved
 * Step 3: giam so luong quantityTrashComment
 * Step 4: tang so luong quantityApprovedComment
 * @return phuc hoi comment tu rac thanh approved
 **************************************************/
let ajaxRestoreComment = (id)=>{
	$.ajax({
		type: "get",
		url: `${URL}restore-comment.htm`,
		data: {id: id},
		success: function(data)
		{
			if( data == "success")
			{
				Swal.fire(
                'Hoàn tất!',
                'Thao tác thành công',
                'success'
              );
				/*Step 2a */
				$(`.text-center[data-uid=${id}]`).find("span:first").replaceWith("<span class='fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-info-light text-info'>pending</span>")
				
				/*Step 2b */
				$(".commentcontent").find(`.btn-group[data-uid=${id}] button`).remove();
				$(".commentcontent")
				.find(`.btn-group[data-uid=${id}]`)
				.append(`<button type="button" data-uid=${ id } class="btn-option btn-approve-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                       		Chấp thuận
                       </button>
                       
                       <button type="button" data-uid=${ id } class="btn-option btn-trash-comment btn-trash-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                   			Thùng rác
                   	   </button>`);


				/*Step 3 */
				let quantityTrashComment = $("#quantityTrashComment").text();
				let leftQuantityTrashComment = Number( quantityTrashComment - 1);
				$("#quantityTrashComment").text(leftQuantityTrashComment);
				
				
				
				/*Step 4 */
				let quantityApprovedComment = +$("#quantityApprovedComment").text();
				let leftQuantityApprovedComment = Number( quantityApprovedComment + 1);
				$("#quantityApprovedComment").text(leftQuantityApprovedComment);
				
			}
			/*IN THONG BAO NEU THAT BAI */
			else
			{
				Swal.fire(
			      'Thất bại !',
			      'Thao tác xảy ra sự cố',
			      'error'
			    );
			}
		}
	})
}



/**************************************************
 * @author Phong
 * @return chuyen mot comment tu trang thai approved|pending sang trash
 **************************************************/
let trashComment = () =>{
	$(".btn-trash-comment").unbind("click").on("click", function(){
		let id = $(this).data("uid");
		
		Swal.fire({
            title: 'Bạn có chắc chắn muốn chuyển vào thùng rác không ?',
            text: "Bạn có thể chỉnh lại trạng thái ngay khi thao tác kết thúc!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			  ajaxTrashComment(id);
				
            }
          })
	});
}



let ajaxTrashComment = (id) =>{
	$.ajax({
		type: "get",
		url: `${URL}trash-comment.htm`,
		data: {id: id},
		success: function(data)
		{
			if( data == "success")
			{
				Swal.fire(
                'Hoàn tất!',
                'Thao tác thành công',
                'success'
              );
				
				/*Step 2a */
				$(`.text-center[data-uid=${id}]`).find("span:first").replaceWith("<span class='fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-danger-light text-danger'>trash</span>")
				
				/*Step 2b */
				$(".commentcontent").find(`.btn-group[data-uid=${id}] button`).remove();
				$(".commentcontent").find(`.btn-group[data-uid=${id}] a`).remove();
				$(".commentcontent")
				.find(`.btn-group[data-uid=${id}]`)
				.append(`<button type="button" data-uid=${ id } class="btn-option btn-restore-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip" >
                       		Phục hồi
                       </button>
                   
                       	<button type="button" data-uid=${ id } class="btn-option btn-remove-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip" title="">
                       		Xoá
                       </button>`);
				
				
				/*Step 3 */
				let quantityTrashComment = +$("#quantityTrashComment").text();
				let leftQuantityTrashComment = quantityTrashComment + 1;
				$("#quantityTrashComment").text(leftQuantityTrashComment);
				
				/*Step 4 */
				let quantityApprovedComment = +$("#quantityApprovedComment").text();
				let leftQuantityApprovedComment = quantityApprovedComment - 1;
				$("#quantityApprovedComment").text(leftQuantityApprovedComment);
				
			}
			/*IN THONG BAO NEU THAT BAI */
			else
			{
				Swal.fire(
			      'Thất bại !',
			      'Thao tác xảy ra sự cố',
			      'error'
			    );
			}
			
		}
	})
}



/**************************************************
 * @author Phong
 * @return nut phan hoi binh luan cua comment
 **************************************************/
let responseComment = () =>{
	/* HIEN FORM TRA LOI PHAN HOI VA TAM AN DI BANG COMMENT */
	$(".btn-response-comment").unbind("click").on("click", function(){
		/*lay ra id cua comment can tra loi */
		let id = $(".btn-response-comment").parent().data("uid");
		console.log("IP NHAN DUOC : " + id);
		
	    $(`.center[data-uid=${id}]`).show();
	    $(".table").hide();
	});
	
	/* AN FORM TRA LOI VA HIEN BANG COMMENT */
	$(".btn-close-response").unbind("click").on("click", function(){
		/*lay ra id cua comment can tra loi */
		let id = $(this).parent().data("uid");
		
		
		$(`.center[data-uid=${id}]`).hide();
		$(".table").show();
	});
}



/**************************************************
 * @author Phong
 * @return xu ly nut luu lai trong form phan hoi binh luan
 **************************************************/
let confirmResponseComment = ()=> {
	$(".btn-confirm-response-comment").unbind("click").on("click", function(){
		
		let id = $(this).data("uid");
		let content = $("#content").val();
		
		$.ajax({
			type: "POST",
			url: `${URL}response-comment.htm`,
			data: { id: id, content: content},
			success: function(data){
				if( data == "success")
				{
					Swal.fire('Hoàn tất!','Thao tác thành công','success').then( (result)=>{
				            if (result.isConfirmed) 
							{
							  /* Nhan OK -> Dieu huong ve admin/comment.htm */
					  		  window.location.href = `${URL}comment.htm`;
				            }
					  });
				}
				else
				{
					Swal.fire(
				      'Thất bại !',
				      'Thao tác xảy ra sự cố',
				      'error'
				    );
				}
			}
		});
		});
}



/**************************************************
 * @author Phong
 * @return huy phan hoi comment
 **************************************************/
let cancelResponseComment = () =>{
	$(".btn-cancel-response-comment").unbind("click").on("click", function(){
		/*Step 1 */
		Swal.fire({
            title: 'Bạn có chắc chắn muốn hủy không ?',
            text: "Bạn không thể khôi phục hành động này!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			  /* Nhan OK -> Dieu huong ve admin/comment.htm */
			  window.location.href = `${URL}comment.htm`;
				
            }
          })
	})
}



/**************************************************
 * @author Phong
 * @return xu ly nut chap thuan, chuyen trang thai tu pending len approved
 **************************************************/
let approveComment = () =>{
	$(".btn-approve-comment").unbind("click").on("click", function(){
		
		let id = $(this).data("uid");
		
		/*Step 1 */
		Swal.fire({
            title: 'Bạn có chắc chắn không ?',
            text: "Bạn có thể khôi phục hành động này khi kết thúc hành động này!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			  ajaxApproveComment(id);
				
            }
          })
	});
}




let ajaxApproveComment = (id)=>{
	$.ajax({
		type: "GET",
		url: `${URL}approve-comment.htm`,
		data: {id : id},
		success: function(data)
		{
			if( data == "success")
			{
				Swal.fire('Hoàn tất!','Thao tác thành công','success');
				
				/*Step 2a */
				$(`.text-center[data-uid=${id}]`).find("span:first").replaceWith("<span class='fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-success-light text-success'>approved</span>")
				
				/*Step 2b */
				$(".commentcontent").find(`.btn-group[data-uid=${id}] button`).remove();
				
				$(".commentcontent")
				.find(`.btn-group[data-uid=${id}]`)
				.append(`<a type="button" href="${URL }/response-comment-${ id }.htm" class="btn-option btn-response-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                         		Phản hồi
                         </a>
                         <button type="button" data-uid=${ id } class="btn-option btn-trash-comment btn btn-sm btn-alt-secondary" data-bs-toggle="tooltip">
                         		Thùng rác
                         </button>`);
				
				
				/*Step 3 */
				let quantityPendingComment = +$("#quantityPendingComment").text();
				let leftQuantityPendingComment = quantityPendingComment + 1;
				$("#quantityPendingComment").text(leftQuantityPendingComment);
				
				/*Step 4 */
				let quantityApprovedComment = +$("#quantityApprovedComment").text();
				let leftQuantityApprovedComment = quantityApprovedComment + 1;
				$("#quantityApprovedComment").text(leftQuantityApprovedComment);
				
			}
			/*IN THONG BAO NEU THAT BAI */
			else
			{
				Swal.fire(
			      'Thất bại !',
			      'Thao tác xảy ra sự cố',
			      'error'
			    );
			}
		}
	})
}


$(document).ready(function(){
	
	removeComment();
	
	restoreComment();
	
	trashComment();
	
	approveComment();
	
	
	confirmResponseComment();
	
	cancelResponseComment();
});