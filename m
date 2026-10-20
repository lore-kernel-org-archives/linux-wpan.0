Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792479305;
	b=jvxaGBf6WMnUJrepGioKXZC+cQjgzjKCZdaQ8XNtBoq8jiDICIDikfMdYXjnYFRRe0kE
	 tZ3iyrgPpoTm0V+isWo+EqiCB9vKw1TEvMFg2X4Lbx0qS7+5BMyqRMqsTFzun84kLsDaE
	 Jzc24GbTgn1q7p3z0SJ3J/zfkTQtVbi1iu9HMAAAVpkfJFsF63aMqrjmZmS1qrcFMZzH5
	 cWq3BGa3t1/M00TxEFloHh+gY3crQpra2MNDvgeKc0oFwICKyauQ/J52IFg7gyJzZPocu
	 6lF6dd02ADh2m6fGAE+TrYE3175rE1RxIVYk/Pl5cgHrdtHUFNO6wlh60ZsQep+O0Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
	b=lQDxMr7G18AKEaKoP/3+ElIRs7/1djxaWWF9BE+WFZ1BmCc/5xRognyzueqOZoTxP9ZF
	 J7w4o7RStDKtWH0R7Iu7qsYF4hIa6ElPFCMa5KZl0Wh2/gw9h01Caf8qMJzRHiMzCsVMc
	 6t6DUPXa82eaxYpgD185VTn8QCV8cqSTHnh/qc1fFmXog+ULHyc/eManyO1X7GTdtweiF
	 NfCnsiaOE4O4O8wTri6oWx0f346tw+hq8LXaYBggea8ETOpBAQsOU1y0lKd4JRfVPKHQo
	 L8YQ0dyv06PAyf1H4LYtoerMoOAzHuUKqfotEcQGE+hNhODeuhj8k2Tp2MEwZKLLV8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="IMgT/bsm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F3606A321
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 06:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE8F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IMgT/bsm
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1688432f8f.2
        for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2026 23:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792479298; cv=none;
        d=google.com; s=arc-20260327;
        b=P9wlR6vF8SirHYLvAw/34+LVvO9/9dL8Ut8BhoWCBC0OHbUMuXU0oxi0OoiWWx7EPF
         4DAl+Uh0iVq+ZDGAcwcvWtMPkheQ/VdVO7G+Z3vBMuWD980O8lpvclFSa1kJzJEiZUlO
         eNLJRZWUGBEz6d04NHBIzXkP19YujiTrU12UaNp0GBnhYIgiFHzj2Xhd8FSLIFbXpbfA
         mMcpKYm90RXlEqgu/fjPMTn+a+OeB/9RWfaAlaRZy7jiKt6Rz+lT0/klF6HGV7cSkxxZ
         ITYjdPLRThdhQYpHMjKBwE605vfpYYvVvFHXTikGXrkpddYGOzhWnFbdnFvfQDtaCDkU
         DB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
        fh=3TFUXZaiEtB/M6YjBUW3vA+G8RTrgQtCkGJqTzKtOeU=;
        b=dUETM8/O0bbH0c5hwbBfXcwes9ACW//fN20hb4YxzAodeMFK+FdXEkK4/df0xts5vv
         imFDrdW1PaSWbh5Gr6OuvsIYjsP4262uh+cMB0jPrSsKjxFBiehDfmAns/OBYn4QBUGJ
         38Kot1y+UJ+ZFnhPZdHim+53HNNwGaTHMPOTnuqFl8I03EiYmm1LeUnq1gxQ+Z9I+fxM
         a7WrskSPfDJ+lmQG7ZNUMVWr3s9J9/r6pWQ+xkOtyB67bCOP0+2/CdTnsAVTbuOfypYY
         bHrmDjOWl3jnuPcgQ/VqPSRBKbweIL+CaXN/9cqE085BRSFj71bXl9rLH94ObE+7afxZ
         3Juw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792479298; x=1793084098; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
        b=IMgT/bsmwHQjBY9wVPzc+O2aY2wzalSMejfFvZGc2QkJ4ZaGTmiTLC/0Gz7oStr3r0
         wxBrGLzDDIxX9pp7dd+EjjV074V3DU/CU/MyNH0oCKofyOjjGrA2eSAyzB2LmOV18NIc
         gQGGoHedexwhj0Cro0OLj/SlqEBvt5Ck5CKx/8HpRmL47c2hytqjVXQnq9uK2AaLhOxv
         WjjuEvtLyWkvlU9rV/3biBA9xrOFSZt+JbuIJWAaTnwBeBTsPMS0dj70CwJOwtdXrhTD
         EZZ61m2u6xpndHZOYIltxHQrEiCb8SdNzT+z6LDsAB5XVpu79ReFJkAeuqvh+h8HUDlg
         ycdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479298; x=1793084098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
        b=cPslAP/M58/epA2zGvScqwWNZcC6w2dpKnvv72LHfCrjrZH6gtoTHf1la9dA4eyL2p
         IjrLSkISBZ62ds2KG9G8rEEavrAxvheqlAEPigLY+vwt7SPXHoZrHd2dVPpwevYvhBNC
         zf7eTOn9JmGrk/xXrnX1nFXeWLh1uoVkL7n675FIw1SBiVyOxF5NQvx1VU4C29rWwDi2
         b41FMHPgNNHCmli+4stTue0l6hU3mRIxuOoE1GA0RXboKLXlBhdhQuIDQACqTkqJq0nU
         FHnpHmTFYjFxnZV+kokWTh9uE2U1qi+6AOMW6Wz+oqHGiRUyRo+ZZq0cvrkzWs/x3gxt
         P4CA==
X-Forwarded-Encrypted: i=1; AKwUvBywtXzygi7bF9anNDmkcYsX7gGJ/REHTiR0ajBv+0Cy4nInExN13hsEhLJHQB4j3H4WrDMXovHxYjzV@vger.kernel.org
X-Gm-Message-State: AFq9FYIUifM5DEjLHkEh/va0hcDBt/51e2Q91bdxs/v8eid6VTGjJxOA
	Da7hxzvRvjty82tdMzeiMq3lYzq3Oy8RIqEZJmM2AB94J48i5LzSXBg4rr5Iw3PJQ0TXcd+RDCO
	wmAyKAb/iBSeR7NDQo4SZLMhruuLW1Sw=
X-Gm-Gg: AYBFou0+qy4+kBn4kmZfOudbQjTJ5sWDaoTyTCP6YJN7SpIJuDfhuoqZD3SEVr62sPc
	IPlTydYj5og8ECJZ7/1dxjOaaaQgf0korRZayFS6EOUcog2tprqvc17J/O9rYu1LFWr2/mn4rLF
	si8gQWdSVGEiJP+WfHSUaG9qmoAZZsM5PvDHxRkAVdhTgEYJL0PYEjTcdTmXW/6bGf4iLWctwOB
	BYj9m5FkZbqkqNSY4HyZrPsDb7OASjlUWOPdTkx1nbvZOAHt9E5QJXH93LHPeDdtDWnYXIWbkj2
	Hj5gWla4gSsvT/ujjn3WQL1TyelZSzCk607KZnkHJQxbOC3gGN/NRzw=
X-Received: by 2002:a05:6000:4287:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e0f071653mr14185722f8f.38.1792479297921; Mon, 19 Oct 2026
 23:54:57 -0700 (PDT)
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260920165057.3753458-1-maoyixie.tju@gmail.com> <20261019151322.8175-1-chandru.gopi.dev@gmail.com>
In-Reply-To: <20261019151322.8175-1-chandru.gopi.dev@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 20 Oct 2026 14:54:46 +0800
X-Gm-Features: AclHuK8JifTJKHboXY-hs4VNAOnYZZ8jD2r4TOVYfzu6ntoqa-h5dqwxPXYyvTk
Message-ID: <CAHPEe=FsFgZCv7v7oeVopR9JFH0ONpPH14O7g_Rg9uUcYQw+Kg@mail.gmail.com>
Subject: Re: nl802154: GET_WPAN_PHY dump resolves NL802154_ATTR_IFINDEX in init_net
To: Chandru Gopi <chandru.gopi.dev@gmail.com>
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, stefan@datenfreihafen.org
Content-Type: text/plain; charset="UTF-8"

Thanks for reproducing it and testing the change. I have sent the patch:

https://lore.kernel.org/all/20261020065125.896530-1-maoyixie.tju@gmail.com/

If you like, a Tested-by on that thread would help.

Thanks,
Maoyi
