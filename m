Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:38588 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757127AbdHYOs7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 25 Aug 2017 10:48:59 -0400
Received: by mail-qk0-f180.google.com with SMTP id o184so12402332qkc.5
        for <linux-wpan@vger.kernel.org>; Fri, 25 Aug 2017 07:48:59 -0700 (PDT)
Message-ID: <1503672536.4722.20.camel@redhat.com>
Subject: Re: [PATCH 7/7] SUNRPC: make kvec const
From: Jeff Layton <jlayton@redhat.com>
Date: Fri, 25 Aug 2017 10:48:56 -0400
In-Reply-To: <1503670907-23221-8-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
         <1503670907-23221-8-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org

On Fri, 2017-08-25 at 19:51 +0530, Bhumika Goyal wrote:
> Make this const as it is only used during a copy operation.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  net/sunrpc/xdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index e34f4ee..a096025 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -998,7 +998,7 @@ void xdr_enter_page(struct xdr_stream *xdr, unsigned int len)
>  }
>  EXPORT_SYMBOL_GPL(xdr_enter_page);
>  
> -static struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
> +static const struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
>  
>  void
>  xdr_buf_from_iov(struct kvec *iov, struct xdr_buf *buf)

Reviewed-by: Jeff Layton <jlayton@redhat.com>
