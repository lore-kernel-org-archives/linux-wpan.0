Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE3406285
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096738; cv=pass; b=RDtlRRwFW2XZ2LkdaFfLaaApHK+g6/soxn/Cf8psDTqXLBo+nq366Q5FLvArgFU8ttkvddxkHCg+/RjJdFfgcegLyYfcEzBuTGbX4WJiyiWKKNTqiDM2UeGwEev9Wa2n81WrZQYEISkDSPfY3WzPdV1heUCPJjLSPTEuxME7zjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096738; c=relaxed/simple;
	bh=QHUqVSv2KaaURqb9cPHR7aND7tqFpUEAhdFRJWdcb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxWxS59LvTeTxSRbsfbFFy6HyfFjDaqYsJK7SU5X3GrBzf4j9lhjLIj4+WwaEskIXvdtrO2DyOpfUP5u4TaQNadDqpdJeem1tyK07gqEABnQDB7Ve5HkCMFVGOb6F2LcVP5bNhfdtRkvns9zT9+YtFlyCll2habCL+Sfasya4jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDWiPKVy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pbZMc/Xw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDWiPKVy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pbZMc/Xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
	b=iDWiPKVy/VQNbsXOjKvEYGaWY8dc8b4PoQnAnDI6pGBB2ousEYSHxGYsD1jWj7MDnvWjcK
	65Hf5nhz2o3yq8mwhQJ5tJY2I7M/A+jfz0058G+K69sQSR4tS0PxmaMSVcsmMrUttBLOEb
	66n/fBIuMWoDIM5TvgM1vfA+faNuCVI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-8rIkeaKNOB6SC_V6aEv65Q-1; Wed, 10 Jun 2026 09:05:33 -0400
X-MC-Unique: 8rIkeaKNOB6SC_V6aEv65Q-1
X-Mimecast-MFC-AGG-ID: 8rIkeaKNOB6SC_V6aEv65Q_1781096732
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-396aa7e1369so33143711fa.3
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096732; cv=none;
        d=google.com; s=arc-20240605;
        b=Vqy1vM49E2hYwFGGt4+6t37tjc49RI3alHO0o33G4ibrkZSoiOYAj4AC5jLVQbVwYj
         81beq9OK7IfqIYcMfJ/5m0E2y0rmd0JMi3C6mElYb2sM8OT0sxZP8GydLFPWGip/gycm
         TUkgZg9FUsxUFq+6zQDSv0067+DWoZ0UAJL+moMkee5ZL5kbXDUR6BXQ+7mCmErxTQ0o
         4bB6o3rsPJ5eWjFgJOxXYCk22eJ2/p3wYJ4gWPk3YQ1/uAg5VmLKKNrwgrt+xFKB03WW
         wPkOV12tKUMVDo5UkdWG87JfLhz2XGEecH/vOO1j3yY3TmPB20ybeiIZfd+salYPVCJ3
         1bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        fh=fAjm2Cwasxa4Ucb9YHy/V2O2y0gwvkKg71a0Pk31rHg=;
        b=H3CXWlX7XUYnvho32Lx3gYEQYsV/g2CqY5iJt2UPYHADwG9Xsh+PFCcmjDA3GZIT7F
         5us/r4r47+39TyuPQKPAd91Lcy5pfwQHMxWCgZtcGR2VhfRj9XchpZLmeNRv6beHyyL1
         8beKsR33ZLH5IQe5ivjhy39OKUlM5VGZLuGk+80B3LsfIa7E/sCTB8UywZGoPte+GZgq
         AhUfG/F/B5E4Mb5X4kib0EMu9Dcz5pP6J3Z3g5QLSRWkjxy1Fj2LkCmGExEX9DJR1CLf
         MwfNtDPUcf5RVFOu0bUgCozrBRJhWbVbiF4axeO7iIs6UJFWMLAZkUnQG4vcVSYsjd8g
         iKvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781096732; x=1781701532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=pbZMc/Xw+cPI5jy3mjU1SS2z8qNoejkT16j3tFJa1c/2w/H79vvfg1xiLjjrsUWccp
         ivurrxwIi0A/sIfXvtKNKXHGiXqO5lBB9sOtdMSfuQ99a9A9WxDgfzC8vX3+OJEDnBhU
         2onfxob1uNwfnPDYaSzG+EVflq4NYkhGtqTMVBfS0Gp1pZftiL/AHqEFahSnBs5RBlyk
         U+YFYD11zHaj3DqbGWL/0pVotQGTgcnJTZ068WANRNl8DFO9K1DAwziGLIU1lH9BpYhp
         TQOWXU+dD/drm/4OR9zjqJkkSBXzehx1OzEcFqMurxWDwRp2OQcAoCG/fYu73sUI0+R2
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096732; x=1781701532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=BtygCztV6vdS2hbyvv2N6c3GjcNisoyQkPJCQbdINZgBoMfbWhmdzP8HZe97Snu/rL
         9vU3afXtzx/BDN96yFUNjWlt/iurLmOHrK9koCkPk5hXvDI5EridYzxsaBSGzgIwVl2w
         BFAZiwPIYoTaRc6KXBRk1BMow6CmDVVEnrn5bVJ0rT+2DMPXJmiI9ZFtRGEpFFks1P8E
         iw3JoN+wEit+/9HbZgJHYkMuVTH7afBd+9dR+vO/VBZUB+aLbEFxjbTO/g3u3IjktaK8
         I7arSw3Bx2dkJWIgFB7MJV7sdURsykEXWCQGZEJ8PxHbR0t6DUYsLtZ61o+aETwkKa9b
         TTLQ==
X-Forwarded-Encrypted: i=1; AFNElJ90NH0IFuRUbTOc2c853mZmuDN/FLPuRZpuQ6IqTbi7DywZD3DSnoCstHQfBwH2MieTOQOwRwincetM@vger.kernel.org
X-Gm-Message-State: AOJu0YxmfhJAt5qUd5eZrSMyIuz0NXWYaRvGH6O11c6aPf9DdPvD3zo1
	kxRcWym8b40KUBXoeSTzVV5d/tlKStQ+IR7KLR1GW2mtL6mAeRlEd8XSUepvxjFm2C4WeG4nU0q
	SPc6ah0W74btgC2ZAFOOq/2fz51kVSrkzSdvsnmo55n2Hy2+jFJyxpak5wfLomHExOxxMpNxU2Y
	m9hYwGL1R2BFBkRnlZE8RZuKVntdrVjxihbyB+0A==
X-Gm-Gg: Acq92OGHtYYwSLEdMd39GV+xbqfr/9Y7n68TSzPYv4YjJP8NTwa4w45aBzvIlscUux+
	CC1S/mxF0wIA0vH7D9q6qoI0WB9n8Ir7WM/Sj3KyAxa9NH2t9pwy7v3NVaEUMafeLkg4r/jE8kW
	ZhxbTMwJcVzh9kqHycNBneI4Y61YaWwudtzcCRXOo+IMdIHsSbFetes8rsym97sg5oSn9xAQhSf
	/+xZlmiQV00/tvThSAFnopx1fxjK+diieB5ey9apoULdrLL
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id 38308e7fff4ca-397f76b9dcamr15845931fa.1.1781096731788;
        Wed, 10 Jun 2026 06:05:31 -0700 (PDT)
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id
 38308e7fff4ca-397f76b9dcamr15845841fa.1.1781096731250; Wed, 10 Jun 2026
 06:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 10 Jun 2026 09:05:20 -0400
X-Gm-Features: AVVi8CdjmsGRE34cD71VHNMaCGfKHZ-mvsXk7Qa_Y4MIS1SxRudAtkLHluKhK4k
Message-ID: <CAK-6q+jL4D6cCwJYr3AMb_h_gVxCamNrG=bRrEczhN8PVRVPOg@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: fix NHC entry use-after-free on error path
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 9, 2026 at 4:03=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> lowpan_nhc_do_uncompression() looks up an NHC descriptor while holding
> lowpan_nhc_lock.  If the descriptor has no uncompress callback, the error
> path drops the lock before printing nhc->name.
>
> lowpan_nhc_del() removes descriptors under the same lock and then relies
> on synchronize_net() before the owning module can be unloaded.  That only
> waits for net RX RCU readers.  lowpan_header_decompress() is also exporte=
d
> and can be reached from callers that are not necessarily covered by the n=
et
> core RX critical section, for example the Bluetooth 6LoWPAN L2CAP receive
> path.
>
> This leaves a race where one task drops lowpan_nhc_lock in the error path=
,
> another task unregisters and frees the matching descriptor after
> synchronize_net() returns, and the first task then dereferences nhc->name
> for the warning.
>
> With the post-unlock window widened, KASAN reports:
>
>   BUG: KASAN: slab-use-after-free in lowpan_nhc_do_uncompression+0x1f4/0x=
220
>   Read of size 8
>   lowpan_nhc_do_uncompression
>   lowpan_header_decompress
>
> Fix this by printing the warning before dropping lowpan_nhc_lock, so the
> descriptor name is read while unregister is still excluded.  The malforme=
d
> packet is still rejected with -ENOTSUPP.
>
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

looks good. Thanks.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

