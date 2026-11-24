Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546096;
	b=W4Xk4SxFxXXTgLtnycIiKq2d9go6vHdznlRz0ZxaUWFGLs94aP2ESV+FYRHO930Dvfr4
	 07b91nf6bY9DvWz1wdu3eyyDOInndnHG5+QGJpV+qenMwhwdymEjX+yGH9ELlRSy5d0+A
	 ComUxQPpJYNDnPo5JbWPOeNCR0b9ZvBSTl1Ho+hUZBZh30EjaT/WgK5JZYwpjeqRcwXxd
	 ooY8EvN3iP3DdoP6TVtF+P7g8ryAbb5lpxH0xKReZGHPVLGpeg8tF2F8B/Kj06GhQ6G49
	 BIOBUevmRj5JPirD1NAVvKw5yHdEYhj0sPDvFjSovBZjRzENMFwZnMk5QAk3Z4x19sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546096;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=XBzDKPy8F5atVthy1/b+yB4P2BpBTE8nfPxwYLvRUlA=;
	b=UBkAZgAJOzh6rNLxHtGavs6C4c38OgR4NnTHCH/wC3n1tFZnTSN9j/N0Wg5+Ie21+KRy
	 Nai3eS4c4McAztAXRzzbWJCwpXlFuU06ETDN1F/+8SWCxMDG9KuoORdxkkSr1fVmRZhHj
	 EGyADgrc/WMdSizu1Wk63mfK6tcP+N2D/qDhL4fVbZGcCwxpirzYMoCJr1pavAYFk+Vv5
	 1gyjW2FFhWCBOXfUGdWUay/O/PCkZse/1tfp0uIVHAkxQrNP9jZM+wXr4rbk18dDQOhle
	 m8DzifU1UFmS8/pB0zrAfA3GhF4aDvDO2eQpzmfY4GL+GUzRpi4Q14h1NkVbocQSwVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oSOHBSUB;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12F606A321
	for <linux-wpan@vger.kernel.org>; Tue, 24 Nov 2026 18:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B12F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oSOHBSUB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2BCF6C2BB32
	for <linux-wpan@vger.kernel.org>; Tue, 24 Nov 2026 18:48:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72EEA601E1;
	Tue, 24 Nov 2026 18:48:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE0A311E69B24;
	Tue, 24 Nov 2026 19:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795546087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XBzDKPy8F5atVthy1/b+yB4P2BpBTE8nfPxwYLvRUlA=;
	b=oSOHBSUBxG/QjZ8d8nZY+rHMg62PZfnFkOoAyjGxNqLMJuZfCyqHI9McElp46SpNSSqaem
	Va7jzAdPY87J8Pd8Z9llt/kXToQTKuca0H9xXh609tDtMR2khrHponTR0SBDSq2IkeJOyM
	gp58odi8NrnVa8l5SuMT0D0T8MoaKq9Whd2dv+94gfcUK00vQMw1GXLFuGNvIyz3ltUw2m
	yueKJ2yhOvrmONqgECu9MD67dlg8hWVAbbXWpGe0qHwXr3d7M9HrP5EYzDsqZFt6qr6+dT
	8tXA8xkHXu30ihBBreT/Kj6iEw7jC2rfqDYBk5IzA+vc8Qeb063fIIfJr2KJzw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Keon-Hyeong <leegun25@proton.me>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH net] mac802154: take RTNL around ASSOC RESP transmission
In-Reply-To: <20261121150835.256812-1-leegun25@proton.me> (Lee Keon-Hyeong's
	message of "Sat, 21 Nov 2026 15:08:43 +0000")
References: <20261121150835.256812-1-leegun25@proton.me>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Nov 2026 19:48:06 +0100
Message-ID: <87se0qqd5l.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 21/11/2026 at 15:08:43 GMT, Lee Keon-Hyeong <leegun25@proton.me> wrote:

> mac802154_process_association_req() runs from the rx_mac_cmd workqueue.
> The missing RTNL was identified during an LLM-assisted code audit of the
> mac802154 association handling path.  The function builds the ASSOC RESP
> and sends it through
> mac802154_send_association_resp_locked() -> ieee802154_mlme_tx_locked(),
> which asserts the RTNL and calls ieee802154_sync_queue().  The worker does
> not hold the RTNL: this triggers an RTNL assertion failure whenever an
> ASSOC REQ reaches the response transmission path.  With panic_on_warn=3D1=
 a
> single unauthenticated frame panics the kernel, even with
> max_associations=3D0 (a rejected request still sends a response).
>
> Take the RTNL before association_lock, matching the netlink lock order
> (RTNL then association_lock), and release it after the association lock on
> all exits.
>
> Reproduced with a monitor/coordinator pair on mac802154_hwsim; the same
> test is silent with this patch.  On a CONFIG_PROVE_LOCKING kernel 86,891
> association requests were sent while the coordinator was brought down and
> up 1,200 times and recreated 71 times: no lockdep report, no hang and no
> warning, and the longest down transition took about 4 ms.  The
> panic_on_warn run (22,941 requests, 300 down/up cycles) also completed.
> There is no in-tree selftest for this path; the checks above use a
> dedicated hwsim harness.

Ok, we can definitely align on the observation but the approach may not
stand.

First let's approach the numbers. 4ms is on a locally run simulator. You
are fixing a subsystem that plays with radios. A physical IEEE802154
radio would probably bring the usual bad case to > 100ms, and worth case
would be above the 1s boundary. So taking the RTNL lock as you do it
there would no longer warn in dev mode, but might lead to a DoS.

Reviewing your patch makes me realize we do something even worse: up to
10s waiting with the RTNL when waiting for an association response (for
which we are ouselves the initiator). That is slightly less a problem
since it is not remotely triggerable like the approach you propose, but
still.

I don't remember why we *had* to take the RTNL in the mlme_tx path.

Alex, maybe you remember why?

Thanks,
Miqu=C3=A8l
