Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43943439354;
	Thu, 23 Jul 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802568; cv=none; b=WkjAaUvZA8ixO/BMjLiNBs6xGSp+MdWuYUvXvzXhUMr9nB/hPyOnXBU0d8zt6LuhDV+iGkAQFKsqWGPcPhOwGxfJo+mAloYt+8tikvxvTgyFyL0xsVwGTEFNg7HXZ8AMB0d+qExyqLIXYkVUBvswi2U4Dzbn0uJfiIPAwTJjHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802568; c=relaxed/simple;
	bh=qTUyhk91I75+Umc1TEa8UN25UXC4ZIiLXnrY8mgacfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzKkAxEGMMhYFCmZbkCDK8RxxwXBbBXTy/Cur1zUlqFj9wKCGqymCAR0NY232i4ppEp6j7vDVCKYjFu5krRnmAEsMib+K0RapMxUpUfUf39ZTOx42aiwyYgtHFmOH6Cjqy1EA1jsNiHYAA4a+6kj2Dvl8r/IRlts3cxDwNEMNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rv5fHHmZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FnZooxkp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rv5fHHmZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FnZooxkp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D825EC00B6;
	Thu, 23 Jul 2026 06:29:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Jul 2026 06:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1784802563; x=1784888963; bh=lchuZrFXOk68gmRhfeIFz5dc2LubMGuO
	KxpRdHTRydI=; b=rv5fHHmZAORiSsfDHjarZad3RKabw+0MINfubxY4MyRiMsbZ
	qa9NDqMHv9+LkJek4z6+ESgC9k2wjuIV6MjydjoZnwkI/aWzJ3vADj+nEIB/+Pq+
	2CEMemsamBRSboG+sTu059EfKMVB9pxNOhL27Ibk/qtygxz8NnvpSrZ5mSSfxjPp
	1/t56xnVi/fe0juItgMx/W03GwDUEbT7Eq39a0QTXSysEhfmR/np1qX8xXCsa//g
	RunGKXqN5bCemMWRDOWI/FDnaTNqxxjB9dTgVY6EPz4RecyH5omGO5MamfSjtfYz
	eQzbg4jDdQ/ciLo8FZ3vE9Nors7UL97TdfV2jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784802563; x=
	1784888963; bh=lchuZrFXOk68gmRhfeIFz5dc2LubMGuOKxpRdHTRydI=; b=F
	nZooxkppsLjgbbmzqRUCCHDIwXClvNPVyW4Om320yIKQfLqrYkXhQU1JlBAYlwhK
	W1Qyo6nusS1TyH4lKD2QY8bXOanl8SbC+rZGYE/Bc63wESx0hJN3DecvzOa7EM4I
	ha0yXx+Rqqb9b7V3Xo5L+OuHaITpAMxlkJ0x1hDGxoGNL/laqXuaZlqbn7krUmfG
	cTMkd7Z/S3fkeD87ph3g7NU/h5AmsJK/f4kTAXNu1kqPCSS7pkJopicCuXfedPFf
	lSAVeZBLihZMTeFSSDkQEa5t97oVT+eOZ7R4/Kd1E/NbRTPMH6wCy1nb0l+yDpaJ
	Phn5BBrVJtEP8dyyxvOFA==
X-ME-Sender: <xms:Au1hahsGdYn2tZrLoo_24WuqQNWCmTWkJOc-gFWzwDMVzx2fqRuwtQ>
    <xme:Au1hamUqN5GceCuE_4h5wI7JGjWpeIRYTGDkourGYXP7s8m3dPdWMiPYrR5Km4ZyO
    -HprgmNWbMD6UW77z1SQ4cvlqsyO0jAJpnA6LwEHrZF9Jdnkra98Q8>
X-ME-Received: <xmr:Au1hagSywxjROrjQ59oKzBe6Oukn2u59HYsOFQZfsuDp9At7ZCMdHh2VtDU>
X-ME-Proxy-Cause: dmFkZTFLSw5edvJ4Bbn1iXTp+fBXmF++A4fZBm89RQ6PS9M2Xtmz3m7s4amkcFmrRquDrT
    5RmuE687zgWmN3TQQ1Evef24QsF4QSTnT1eGsVXQdrmxtX9cL3fzFmDA7wCY2Mz7KJ23Yz
    mztVDExENqmSdeCOgYSx4x4WcJeHS1SKQ/gp+ghKFHZFkMfmKJs893tGtl0AD1i+Su4lvY
    zdnKkW+D1IE8LuS0XG0wM1vfg2aUj1sKIZ78SucP0gqf3SOtM1PtOfgmVV4LyKakIssgwr
    Y1/ZsxN2iI3833i9kWFUhbFi3kRXC1UDLn1bJ767G8RR22k+i+1oNluTTFiLpQFxI1WYjk
    mwu6DyKmt/i2q7D56HcUDbiaQ6B7sN2t2X+TYQ1LAlkwGIyEBTiZ1tHts5iqLBqkyyD3Yi
    jGG1FdeiKtDTtvo6O2oGzCGRG6Ms3OrEBnez04QjfDPV04RNLoqj8gVt0FUZf2Fht2n5j1
    fLLeneaGJURbf1Q8UGjxiy/3NBJK6iY1+3R4aT939CYadOu74Bh1DzUq4WFJ30/3pyJQIz
    NoVac8iOpRfOdo88jwyoTEwNb8bKa3z3NIMrEpdN1oqmDKIq+z7IHea9/BIf7703WKzPW5
    W+TwP200U/OPXgRn0YH9Z8DlR/O0rGVko9Kj1b7V6URCeXVwUooOA+aArt2Q
X-ME-Proxy: <xmx:Au1hasJNZUSoxcHIemNE6jLfLRQNS8N84_5bVmKhm5B0oT5Ezixbow>
    <xmx:Au1hap0gQokoC_hd54GwrmmR22YFq3aZwQQTgfR7e1VAEVJOYjInVQ>
    <xmx:Au1hanKHjNERPwGDxAHzVBfqxCo94XW3HAAGB57q9lOUb4idJU54xA>
    <xmx:Au1hahk5aD0CW-WLQ1rPb_hi59wvd0wOEFxjogJcahpgFkF9jvXoEQ>
    <xmx:A-1hao4Msx2RBTay1gQONqjhTkb-gz1oKogOy8TeZzpoZ4ddXAwLmzrI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 06:29:21 -0400 (EDT)
Date: Thu, 23 Jul 2026 12:29:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH net-next v2 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <amHs_xGASCAA1J3k@krikkit>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <20260720-getsockopt_phase4-v2-7-8a08fcfa0d72@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-getsockopt_phase4-v2-7-8a08fcfa0d72@debian.org>

2026-07-20, 09:17:48 -0700, Breno Leitao wrote:
> Add fixtures for the newly converted getsockopt leaves:
> 
>   - rawv6:      IPV6_HDRINCL / IPV6_CHECKSUM int paths + a SOL_RAW
>                 unknown-optname case that reaches do_rawv6_getsockopt().
>   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
>                 rejection.
>   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
>                 rejection.
>   - tls:        TLS_TX_ZEROCOPY_RO, the TLS_TX crypto_info round-trip at
>                 the base and full cipher sizes, the NULL-optval and short
>                 buffer EINVAL paths, and an unknown optname. It skips when
>                 the kernel lacks TLS or AES-GCM.
> 
> Each fixture pins the returned-length / errno semantics across exact,
> oversized and short buffers, an unknown optname and a bogus level. The
> semantics are unchanged by the sockopt_t conversion, so the tests pass
> both before and after the leaf conversions.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> ---

> +/* ---------- tls ---------- */

The TLS tests themselves look good.
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

I guess there's a question here (for components that already have
their own tests, so I think just tls for this patch) about whether
getsockopt tests belong with the other component tests (net/tls.c) or
in this getsockopt_iter group.

-- 
Sabrina
