Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C42D0292
	for <linux-wpan@vger.kernel.org>; Fri, 11 Sep 2026 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089427; cv=pass; b=kDG8xkOn4BUy7JlUeOl79Oz5Bew5etM452EpTggYwdzIA9r80Qe44yJX+v1DEwNHBOz9EFMcd+dc0YDV9iiEJpcOqdZF5TVG4/RGGwsUA41UlVvALOUi+/UJai8X5O2r2rmweyruxMZ+XY2tWpUpPMcVZCNwIx69O6Lf9vGwMHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089427; c=relaxed/simple;
	bh=5q+iL/R4cDrY1TpT6uISBmPsAgAumboJPqFJbP2vER4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrevwsB+FMMdngQymduP5dJVPxxuSRslKTfB1m4OJw6+gUGttR52OcWM0VKArXKGEelVg7uICDejccc8wAMEeOzIACbc0B2yvKDqoZKzz1Abm9aBKGnbOTC95nIre+qzX7Ypt2dvy6GG6mh8Xa8gcxHWkQzevqa+8y34PQwY64c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HijGppF3; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HijGppF3"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd6so5921491cf.1
        for <linux-wpan@vger.kernel.org>; Thu, 10 Sep 2026 18:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789089424; cv=none;
        d=google.com; s=arc-20260327;
        b=MUumW4UPQq3MXcWAH1YN2vCXAof3KnVEzv8ZsoL5izoyjNzXNCSEZzSCsXm1rtrE3y
         JNIH+UsjAPKpg6zb1Q76NkBqvfPPQX7sh6PGPCHIXEJHgLO15mbzWfsxSz+btVD9vv3s
         49ehDjaGe6rWI+2E46gTrR78KanTMJWIi1bhAnPQt4c1bjkBItRs/yacYqJeX6hwOZB+
         wlKNE2DpGdpCjjW2MO3Is3iBCnXwDew0HZcb6T1WvgYjY+LX0zNpMi4otztizUtTBAq8
         4vnSkf6SUgHU75gR9ubLdpA4ZnabChBH8VWFpK/Ye2otGS6CMxQzJlNJUCQwLEL3dl9/
         zG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        fh=ycCw89RRE7nZTpex0acWlcL3Hb9hLB4kDsz4uaAPYqY=;
        b=gUUfUrGiVR89dCyjCRj4l8L9yGOzFTM7Lz1ifuX3X6ghWmAWpe4uaVUr/93Tc4R/wB
         M5TsJqKe9oosL9cJ1CJerHICDVr1ddgvWHXM2nBcRy14BPCjWeqsWRG0rRGDKgcGBnAh
         QHBZ5tWAZPHoYV0UYKt9Hhm1mh82nde5NQG0P5r9/YnXwO3vKwYBbvosT+zn7eHvio4V
         MK6zfmhHy3BiNaOEVxJLxnafoc2t70s1Kbsv0p66TKU49VKSE6bGhoX1ngo+qF/h3RVj
         Fe7eWvgdIevlNmADBwyh5wfKysuinzBnZc/R7P/PXK4Umw1SZcmKagYI7oO+pmhvl10g
         vAhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789089424; x=1789694224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        b=HijGppF3YqI7mjQm+WRnchhbkLIGAn7xuY3LCkZo8iMrhJ1aQ4elSuEjtahnX4xhaZ
         1o4PGE3JPPQNog2RSzhnr0ZeP+TeGRBy0b8igJr+EByUjDl1S5u5jMiNK/07KSEAYWJ0
         A3W+cGhtl42Z54+D0OEYIvUPwO5VGMTWxyDkC4JasInYOJPE8gJy1TyFw+z8KWkBc2Xr
         gmfEWAG4rDDUKOCGHafU8aql42Fqx+lZ6w50GGKHOD285WXr/mOVPJ0XKWG2AHhSHoXv
         2id6kA0htS1/G1IfTxmv2m3LlCDlhSHd9eeRfJq2YzbXV2TRPYvaGE4MJyZaPMChHPsL
         OWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789089424; x=1789694224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5p9NQgPpyH0j9JiAgxiWq3LurVs8yYrQVoiE1QcZUw=;
        b=MGsAMvfVVjybwXLTh/+ZGvo5LswjFKNdBFZbi60FL5JWHM+KpIW3XMpRiUN2oPngW8
         wsoZWr4o/npEnazeg28MwofbtER4t6N2MYmIQ5CBomOkWObn6jk16PHMqU6frkrErbEN
         2XALS3EQ5b+4vs9yVIQm/Mg6aBgYtuS/jI9dNHeTjG8AZmYEiFvYIXfLGbKq4D3n1kjP
         ypLclieMXfYmiTEM9mdhsRaBPfGCTT1cNMfgUXt5cqo7SErFBg4b87SrJkO7oP4KvFAj
         amyP6HTGlP5HcIl4nhn96mExoQSbFTgsrgfDogoKyv/VtsV5dyJXkHuYJSV9By/2k3xG
         Aviw==
X-Forwarded-Encrypted: i=1; AKwUvBxvXbb6Ha4PzBiZ7zq9bpmJjGPTwv+1iD/nbvey/5hkE7bxBC98wP0rWvyovrkB9ZRMnj7I+bq33MiY@vger.kernel.org
X-Gm-Message-State: AFuF++kf2HnbDrrj7qNyKsFzHtkBBq6MB7/vPf2pvNIGXxVnTGDCsEGw
	XY4KNXCw4SOVmIG99eqYeXqoFINHzT2J7FrKO/Kjxpd816tqxPw5FSZdHIAhsjiA7XjRNfqdzrj
	Gw8ewV0vMwqaFMf04p6sjtph0FYo7HtYpEvxDSl09
X-Gm-Gg: AYBFou1n2I2nFAz/htVY+HQnIb1Bgtu9LAEMajHmRn5WJFV7yqY0Whz8SRajqKs0Rau
	rnzPaYWI4TMYxYSXCbFZl5qX+ywvM0obADYRdz66G9zxKM6FUBGdK02EaKhIoXIfYMNXIkf9a2m
	L4zr7OmMHHrnLHUN2SE7+qxZndWoZTYhHFcP7b35K3l5cITmya3uCm/zKhh7gNWJ4xgtHHmZbM2
	YDZi/ntNt728qomCHKVSgK7tHjgcVt5E/UJP1hyW8YPtvZirvyL+38pm59BCxIjcmiNWNzFBrTu
	qs/7t9kWJzbzyeBu1LQXjKIGcSjMGHN96cM5YlDcUVemQ9ci8BsfLbUPlarRehuJQKT3VtiZkeY
	ME2G7uNnPRPT1aK4j9d0e6quT2B0wXthHUSUgggybIffpUDuIGSB6nNFKoNSc42DXS4s0tUAkfn
	ARsvoGCqNahJicpjVD5UGi1S/1tRN2gg==
X-Received: by 2002:ac8:6f11:0:b0:52f:64c4:8094 with SMTP id
 d75a77b69052e-530c87226a9mr49908141cf.39.1789089423282; Thu, 10 Sep 2026
 18:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
In-Reply-To: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Sep 2026 18:16:52 -0700
X-Gm-Features: AcwNN1VGil1vFMyCvGxTO0Uen3SBrfMM4J1yekoBWYuH_50vYwcqY9LxSE-7cx4
Message-ID: <CANn89iJg-10Xy_N_h3Et3wTasS_7RMkwxsz3XKmzYc7mLhKa-Q@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: do not compress headers that are not fully present
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 1:31=E2=80=AFPM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> lowpan_header_compress() pays for the IPHC header it pushes by first
> calling skb_pull(skb, sizeof(struct ipv6hdr)), but that pull is a no-op
> when skb->len is shorter than an IPv6 header, so the unpaid skb_push() ca=
n
> drive skb->data below skb->head and into skb_under_panic().
> lowpan_nhc_check_compression() has the same missing length check,
> committing to the next-header compression path without requiring the
> nhc->nexthdrlen transport bytes that nhc->compress() reads and
> lowpan_nhc_do_compression() then pulls.  Return -EINVAL from
> lowpan_header_compress() when pskb_may_pull() cannot produce a full IPv6
> header, and return -ENOENT from lowpan_nhc_check_compression() unless the
> IPv6 header plus nhc->nexthdrlen bytes are present, so that the nexthdr
> falls back to its inline encoding.
>
> Closes: https://lore.kernel.org/all/CA+0ovCjTsygN76s2o=3DTZqPqW8v2gBhmRnz=
+q6G-NaB3Cq-YPqQ@mail.gmail.com/
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>

Notes in a semi random order.

1) You forgot to tag the net tree in your patch.

2) You forgot the Fixes: tag

Please look at Documentation/process/maintainer-netdev.rst for more details=
.

3) In net/6lowpan/nhc.c, calling pskb_may_pull() inside
lowpan_nhc_check_compression() can reallocate skb->head (via
pskb_expand_head()).
When this happens, the 'hdr' pointer in lowpan_header_compress()
becomes dangling. lowpan_header_compress() continues to dereference
hdr throughout the rest of the function (hdr->nexthdr, hdr->hop_limit,
hdr->saddr, hdr->daddr), leading to a use-after-free.

4) Callers of lowpan_header_compress() do not check its return value.
In net/bluetooth/6lowpan.c (setup_header()) and
net/ieee802154/6lowpan/tx.c (lowpan_header()), the return code of
lowpan_header_compress() is completely ignored. If it returns -EINVAL,
they proceed to transmit the malformed/uncompressed skb anyway.

5) In net/bluetooth/6lowpan.c:setup_header(), there is already an
out-of-bounds read before lowpan_header_compress() is even called:
hdr =3D ipv6_hdr(skb);
...
memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));

If skb->len is less than sizeof(struct ipv6hdr), reading hdr->daddr
is already out of bounds. The driver's transmit path (bt_xmit /
setup_header) needs to validate skb length / pskb_may_pull before
touching the IPv6 header, and must check the return value of
lowpan_header_compress().

Thanks.
