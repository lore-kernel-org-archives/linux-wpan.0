Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793F35675C
	for <linux-wpan@vger.kernel.org>; Sun, 31 May 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780267313; cv=pass; b=b4ucgIIYLtrNI4fHDUd5GpHExtt0V1MUq748jSLqecqoluNgBFI1eCxIiOq17apC+9rVnxMKHKXWIhdQX/JxrzP896oD8rdrihFTDBbXA0b7a0Tjy7oDoUwIckaKBfYf/VIVaAlfncIIW7w7XyfJ7aVqXGDsWtRiSI8VagobBIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780267313; c=relaxed/simple;
	bh=DwqmmYGhzLJZcKctFbT7fQlI57XOCuUvJS2TlMvi4UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kf9R4qDe2/dyP1/5lMhRRg+VLrE2iTWG3KSGVKYEbtHTe4/3Uv9b9nSxfB6oCS+HAK0R8b1hLMp7MlmU2/zirbqhkxqHsSw72BaM4/320VBasO2DiO2RRRUi9rSTLb+2Ki4qQffFUf3xvChWp24r9j6XkOmtjpjz3gEvaotgsjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWHS0PuR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=asuJOGG5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWHS0PuR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="asuJOGG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780267309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
	b=iWHS0PuRQMVKWsQHW0nujbf2mH5MmuBfxMsb+u+3db+FSSS6HsrPqnndrvXrw3sZmp9JO+
	qps48KQDmb2xHGXUMBYHDcOzDkKI+z2ENMDmEn0A7FHLH8So6udDdbLwvvFF0cASHtqMS2
	M69V2G8jc0+mnkOKD2we3HJQ9sl7t5o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-CFW7KldxP86cXKq9zvNkeg-1; Sun, 31 May 2026 18:41:47 -0400
X-MC-Unique: CFW7KldxP86cXKq9zvNkeg-1
X-Mimecast-MFC-AGG-ID: CFW7KldxP86cXKq9zvNkeg_1780267306
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3967720a727so3148451fa.1
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2026 15:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780267306; cv=none;
        d=google.com; s=arc-20240605;
        b=T7hXIL3xdkbNMn+XlaYImGzyoFEkn4KtjSqwWP7uqheWQhpfgf7EuZI9eQJlbEYiee
         sHaS/ss6pSCDJcOQXDGNA56B/hfmFTiwdCRQEi8xzZ6JUEnl4Y1LZHi4zQ97fkRTEvjB
         EZBUYvPdhzkzLn8ae3PF30tCi4pIue+wp6mD8q6YwIZ8WOA93+iw1495JdW/VnZBHG8U
         1MmVrlK3zhBEcmPxB/j7DoDZ6P8+LfrfNpc/BuTIGrZa5oP+XcrNiB4c4MRCLTseCBiH
         QZi1zrdO2MXR+pTVCESiRVsL95Xjirn48snRl6rT60EwzsokaJm0pECV/gndwcfPCQX/
         Z0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        fh=Z5RWiJH2Mg3P32G1YC3dZS3gcT+fInFrE+m4IZL6Wyc=;
        b=k5jvX1tWhujnapX3U0Nf9vQ8Ca4WM+cgIqxwwNLQMhAMZmX+WZCpBLimLc2Xy+227M
         o4o9FiDbF5y2ZE+NNutlavO1Ptvx6eaV9/JvQEHLICyw0e4dpv5D1mRQyygB45eh6eO/
         AFRssYAn6V+RHgjU1f5p1Rt5sS7leYWJ/cg/EzvG+cowt30mQH7dkYPytps0/wuFKbm7
         QsMoQu3A8RwjmHkPnibMWnqqJk6m/Sp5PmTkJsstSoeiv+KiBZw3eo4gFOo3U1FXoqM5
         C9gt+6ppaq173Wm+BZMDDHVKL1Zp4WiHHvyqvgqRPybtvWC5G9Zn10ezBO4Yy5zuGPZd
         SCKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780267306; x=1780872106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        b=asuJOGG5Ik+X70IysGdueIpobpCYSEe/esN26gT3Z0vJVThLoj7gKsee82cG2EpCi5
         A1yBepsAKfxLZNWa3OcXzDGQu8whGgdXzi2BAPrN6BDPVp6a2WjpaHtXI1VuIswdImMA
         OS5ZEoCdRxD4ikZ9XRP84KspwOXo7viFs7FATe3Jj+NOP8PJbQx0HVrkcWkNVoLfJjOv
         dVNa8xjhTwV91vNSk9pJ8JRyz0nnaVGjjKhdngPrBhQJAhW0bvqstscXfn9ann70rbBn
         TNR+q08Oy0ZvwRQl02NxZWQUKYa+5qTkSfQTkSauD/DVwdcf+ZIDCKa3wJmSpZMUmCGP
         V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780267306; x=1780872106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        b=E409kVO3q9+Jf2wBLMnWI4H7MHXXulv6+ltIDG4vIlXmBV2Dgn5wzYqxrkEbxsdjuF
         +HG9Hyt2u1g1GuIPxUZiMqkNF2ttWRB7jDW8zzAlewlX15BgYn1gq9I/VdvgEF4Fah0K
         ckZzk/Jad3S970bNEWYz1iT5ZMUSKnFWGIY2gJMHn9p+M6trW7PHbES/cfeRSG81gMBB
         eKAS5wo+uoieYvbIT0NsA+ZXGqHoueGRA8v13jM0s4ANBkdu6/mgkrb84B2Iys4fJSWm
         cFx99lx17VJqjLjyrHFncRkasM5PezJNoCCkEZgycPCyr7bGpO90XXsvBIrF0nCkc7fm
         nGJw==
X-Forwarded-Encrypted: i=1; AFNElJ/H2CmcmYhzBT+5qqcfuTwbfaweEJmMaUmI8EQvms5x5gF3S3uPFCpMoMIbModxd6g+xglm6xwWinUD@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUZBVmGUzIiBSfJUHCWGhSKa1rhJb80YatSDvaBJdmA7YQGvv
	y7Qo6FSPa9JH2xNg/y2GbVzarYsyHAXLV0tF4ugcwV7ZpCAp34FwOELC/TwrKgBULIK+3ZPzMjf
	NSssfhTx5GJuUK4P+yypWSvOyjw1nxnyH3Uz6ZhIEPuFMNr6+rdaOJjwSpe9ji1EDRU8/aueMZN
	8vlXRRnV5aXBPNHgSfTTvfbj/iI2tc64EW9qQ1Cw==
X-Gm-Gg: Acq92OH8zC0yKfNgplCHvlH8zj8ZqMJYNGCnRcEsse4meowMLhsDlfmjj00rMPiAgG0
	hOtQL80jWG1+EDK2wEWfIRtwVV//ubluMqJT4iAROS33zBuhyJjUuY/ekJtv9APyx4WuXhx3iB7
	Fvw63mf3BNtXB4BeqnmDSFf4WE6STbQj3SHNv5UhWWrdGAv4Y0QaIXJDYAC2ajE9In9bJ9QQONl
	sNMYrGQd0h6JcLvj043Zc6VZfBxC0ROOf3DoTaWcqaUe3aKWg==
X-Received: by 2002:a05:651c:23c4:20b0:394:642:c648 with SMTP id 38308e7fff4ca-39664eaa587mr13988551fa.7.1780267305628;
        Sun, 31 May 2026 15:41:45 -0700 (PDT)
X-Received: by 2002:a05:651c:23c4:20b0:394:642:c648 with SMTP id
 38308e7fff4ca-39664eaa587mr13988491fa.7.1780267305279; Sun, 31 May 2026
 15:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 31 May 2026 18:41:34 -0400
X-Gm-Features: AVHnY4LJsPgo1bw4BMrZmqSj2uYEh9dzW3bfFOpiMMU9XPGtTORtUTQD6jb1c5c
Message-ID: <CAK-6q+i6JsNA0twRp29P_wotODGr98rxo_CcE0n_BAhH_ofUsQ@mail.gmail.com>
Subject: Re: [PATCH net] 6lowpan: fix off-by-one in multicast context address compression
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 27, 2026 at 4:19=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> The second memcpy in lowpan_iphc_mcast_ctx_addr_compress() uses
> &data[1] as destination and &ipaddr->s6_addr[11] as source, but
> both should be offset by one: &data[2] and &ipaddr->s6_addr[12]
> respectively.
>
> This off-by-one has two consequences:
> 1. data[1] is overwritten with s6_addr[11], corrupting the RIID
>    field in the compressed multicast address
> 2. data[5] is never written, so uninitialized kernel stack memory
>    is transmitted over the network via lowpan_push_hc_data(),
>    leaking kernel stack contents
>
> The correct inline data layout must match what the decompression
> function lowpan_uncompress_multicast_ctx_daddr() expects:
>   data[0..1] =3D s6_addr[1..2]  (flags/scope + RIID)
>   data[2..5] =3D s6_addr[12..15] (group ID)
>
> Also zero-initialize the data array as a defensive measure against
> similar bugs in the future.
>
> Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression=
")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index e116d30..37eaff3 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -1086,12 +1086,12 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 =
**hc_ptr,
>                                               const struct lowpan_iphc_ct=
x *ctx,
>                                               const struct in6_addr *ipad=
dr)
>  {
> -       u8 data[6];
> +       u8 data[6] =3D {};
>
>         /* flags/scope, reserved (RIID) */
>         memcpy(data, &ipaddr->s6_addr[1], 2);
>         /* group ID */
> -       memcpy(&data[1], &ipaddr->s6_addr[11], 4);
> +       memcpy(&data[2], &ipaddr->s6_addr[12], 4);
>         lowpan_push_hc_data(hc_ptr, data, 6);
>
>         return LOWPAN_IPHC_DAM_00;

Looks good to me.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

