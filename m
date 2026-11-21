Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273732;
	b=5cExsO8II8jBAQ+jcSWjOlC4uZMJLm6BGEmQFwGaq5Xf4sLYVE7sPbp8WcDvuIhkQ8dj
	 9Ju5R9ecLMSH9/ZDW7XCK53fcfUNbYUzPQNs3HXof3ViXSrY0uJFqjk3Z/34F6Ejm4Tp7
	 8PIbCB4Drnx1zm3dwi9U0NgcHo1i1QyRgjAFPFyCITXeuq6eTYC6SdUj1m3a8+p7RdOKR
	 BVj4+U4eKNyEgAza0ledT3mkvimtNZQdY26hjUZu2iWRVL7iBaTDx1mMIvrI8l+5ieoAP
	 VH2YKNcY7Qiyb3gEdo/Tg/sG/pkl7V9ZrKXIsJ86wYHMf0FzcuHihxojEqyusV6nBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273732;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nf5dZ0QHcFOV0D3Tnm+2uIHAt+M9+9e/y454KmdyMH4=;
	b=x/yYPaJ51fWvDEnOTfCRYcEEz1oFPSos4ar9q64nYFnMk4BsgFyFk71wP9GExwLBisuH
	 t65nkWnOLo+aBgtBF0FjFiGOMuuwjZG1gikX62xWSNjbF7iZ6iwYGQjMITgTFgH2nbXqq
	 3ET3VMu6eFr9UZ53SjlXACCjhdaw/BtPfbDYqgkQ7emSktmlx++jgjr/gZXMj4VewqrCG
	 PVlY5wZ8N7q+vQbGB89UVYyxFNjTdFJ8vtL1XCrG64jZ49EWsMqFx1Wun3d6f9Ku1vswG
	 yqW+yZwyKtMkBUs0KKRF3fSSFDvP09C1rht+/LG1V6Nrxj1k4l6XiSGa4rkKzn06o6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=sC4WEbSQ;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B67606A32A
	for <linux-wpan@vger.kernel.org>; Sat, 21 Nov 2026 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B67606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=sC4WEbSQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795273727; x=1795532927;
	bh=nf5dZ0QHcFOV0D3Tnm+2uIHAt+M9+9e/y454KmdyMH4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sC4WEbSQDEe4bxH5Lrzw7jAXL6H4FjenF02AZmSLZxA7aeRV+PJcLlOm6G9msuLaj
	 9NHrM+AsAg/62SEHlkwtavHUGsDihn6lvf9oFn+UU6UDXzgXpM3hvGwzvx9hScIT/X
	 LFk2rgNj2r4NJU3ta6s+4iffnKwdu9Hf6JId+Jt36PeLcfhFjh4AYyw6DyWRmeLlyn
	 6SbX3f3NWHvyKpkqQLyDkBcaYo8mtCaK7AA4PgGTanMm4fhtWbSO8She9KpO+djLQN
	 KyonfSXsvciUW7WEPqvCPhozP1+BuhS7vSX/aHXfoqhKPnUcv557BMUDnhzmFY/ypB
	 +STm7gWUQpsPg==
Date: Sat, 21 Nov 2026 15:08:43 +0000
To: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com
From: Lee Keon-Hyeong <leegun25@proton.me>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] mac802154: take RTNL around ASSOC RESP transmission
Message-ID: <20261121150835.256812-1-leegun25@proton.me>
Feedback-ID: 167971190:user:proton
X-Pm-Message-ID: 526a5589f878115d95986fa28277bd3e46c7a6fb
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

mac802154_process_association_req() runs from the rx_mac_cmd workqueue.
The missing RTNL was identified during an LLM-assisted code audit of the
mac802154 association handling path.  The function builds the ASSOC RESP
and sends it through
mac802154_send_association_resp_locked() -> ieee802154_mlme_tx_locked(),
which asserts the RTNL and calls ieee802154_sync_queue().  The worker does
not hold the RTNL: this triggers an RTNL assertion failure whenever an
ASSOC REQ reaches the response transmission path.  With panic_on_warn=3D1 a
single unauthenticated frame panics the kernel, even with
max_associations=3D0 (a rejected request still sends a response).

Take the RTNL before association_lock, matching the netlink lock order
(RTNL then association_lock), and release it after the association lock on
all exits.

Reproduced with a monitor/coordinator pair on mac802154_hwsim; the same
test is silent with this patch.  On a CONFIG_PROVE_LOCKING kernel 86,891
association requests were sent while the coordinator was brought down and
up 1,200 times and recreated 71 times: no lockdep report, no hang and no
warning, and the longest down transition took about 4 ms.  The
panic_on_warn run (22,941 requests, 300 down/up cycles) also completed.
There is no in-tree selftest for this path; the checks above use a
dedicated hwsim harness.

Fixes: 601f160b61b2 ("mac802154: Handle association requests from peers")
Signed-off-by: Lee Keon-Hyeong <leegun25@proton.me>
---
 net/mac802154/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index d393b1f4e..49bc5d29b 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -826,6 +826,11 @@ int mac802154_process_association_req(struct ieee80215=
4_sub_if_data *sdata,
 =09=09return -ENODEV;
 =09}
=20
+=09/* mac802154_send_association_resp_locked() uses the MLME TX helpers,
+=09 * which require the RTNL.  Take it before association_lock to keep the
+=09 * same lock order as the netlink paths (RTNL then association_lock).
+=09 */
+=09rtnl_lock();
 =09mutex_lock(&wpan_dev->association_lock);
=20
 =09memcpy(&assoc_req_pl, skb->data, sizeof(assoc_req_pl));
@@ -895,6 +900,7 @@ int mac802154_process_association_req(struct ieee802154=
_sub_if_data *sdata,
=20
 unlock:
 =09mutex_unlock(&wpan_dev->association_lock);
+=09rtnl_unlock();
 =09return ret;
 }
=20
--=20
2.55.0


