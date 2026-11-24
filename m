Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510761;
	b=YoBOFkR0dOCcJ3Zca2HdL90SN+0eCx2tUry2N+uv4XE6ZgDySDZ/x7XWQTx9aCNbgULa
	 Qls9OX3rPJULYKM/jZ6ALeNHhfgYblK8WdIepIbzVB2nQRuQ/G6t4tdoZHVei8flSLcVn
	 PnKUIoX/hZu+Mg4F2bLix93UdKSx/V9rnM/BLYNHbX9/k2QNQOSsJRzCE4SvCnNfmXqDl
	 Yv4rU1uFnvXGVXwh80GuGkeZuKm3N6NheqT5H+S+7c0D2RvY3rfb28AbG+OEQ0dIEZW5t
	 Wbzno0SPidrxeGcPnAYUXYZvWuXEvjSh0AASm0x3yHu6J+MrialZznfpxuknJ5bv26A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510761;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cvD88Dpew8SVgiv7VcJ/DUMXSWbUpGirQIgCbhBQH3c=;
	b=0GW1j5h2A/Y/dk4eBHfgexfaYT8kapnDr0iBFkZkNTVUpQVRT2flxcIReW5HaIW4Vqb+
	 CESmdTSnuDGy30S/NHOIfyDv9I1NtRqnxjg4VwNpy9yqq00LIaunrTkHCEud9vAqkMp97
	 y+NMzyXqrPaXBazhLVvxPHy1De36ksxIbu4e0+IuKi4qy6kBAX+fuzGrjhfIM1wpJgB7a
	 7xayLy2MeeHKKvJgPTg2d3WGEn5sXgfsYnp7yprEF67qbXWWYsHLFd1+dx9jX4SI6mIzN
	 2+hoOYwLMPnrAOg3wgxTUcPoFb5aYscsytXLnpilexLV0EjH6/ccpX/mJkmMg2u9WoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=mr2vrmtnaff5xnycedqfvl3d34.protonmail2 header.b="N7WYfqm/";
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C6606A322;
	Tue, 24 Nov 2026 08:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 274C6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=mr2vrmtnaff5xnycedqfvl3d34.protonmail2 header.b=N7WYfqm/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mr2vrmtnaff5xnycedqfvl3d34.protonmail2; t=1795510758;
	x=1795769958; bh=cvD88Dpew8SVgiv7VcJ/DUMXSWbUpGirQIgCbhBQH3c=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=N7WYfqm/1lxMWASa2LEgxlIPJ98H89+IfFp+c9JNemTadYZRCUs1PXYbgH8WdT6Qh
	 IARqvzGLcAqlKChdSga/XV8/Ixc/1u53fmZHQt0tK8PD3tB+bEnk6JDvqm53Lm6+Jh
	 a0F1s+5cxtbbs+KEe1DRcaTc5rzYxqqhgpo6jsqs7wk7qCNp1R3Vi0wP/HF4AIQJ+D
	 77EKN4u5HevdLoGMfdluQ0+8I8BP3ueypo4C45H7AP0UZBvaAmV7f7PRmpGrU+mk9A
	 +ruWYiSyKzLcpyQtfd1XcPY28an35i3YjSYyykGw+mFmX6zUymQ9hgMjMY4n72axco
	 Blrdh3P9rnbAQ==
Date: Tue, 24 Nov 2026 08:59:12 +0000
To: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com
From: Lee Keon-Hyeong <leegun25@proton.me>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net v2 1/2] mac802154: free a replaced child
Message-ID: <20261124085905.710751-1-leegun25@proton.me>
Feedback-ID: 167971190:user:proton
X-Pm-Message-ID: f8386f8f6079089f21f416f011df4b4613755928
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

When an associated child retransmits an ASSOC REQ, the coordinator
removes the old entry from the list but never frees it.  It also
increments wpan_dev->nchildren even though the number of children
has not changed.

Free the old entry and increment nchildren only when adding a new child.

With alloc_addr=3D0 the lookup in cfg802154_device_is_child() matches:
300 retransmissions from one peer leak 300 kmalloc-32 objects and make
the association table look full.

I found this during an LLM-assisted code review and reproduced it with
mac802154_hwsim.

After 501 retransmissions, the kmalloc-32 object count stayed at 840
with the series applied.  On the unpatched kernel it rose from 780 to
1260.  Kernel selftests were not run.

Fixes: 601f160b61b2 ("mac802154: Handle association requests from peers")
Signed-off-by: Lee Keon-Hyeong <leegun25@proton.me>
---
v2: Drop the added comment and move the lookup fix to patch 2/2.
v1: https://lore.kernel.org/r/20261121133101.240921-1-leegun25@proton.me

 net/mac802154/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index d393b1f4e74e..943641702646 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -888,10 +888,12 @@ int mac802154_process_association_req(struct ieee8021=
54_sub_if_data *sdata,
 =09=09dev_dbg(&sdata->dev->dev,
 =09=09=09"Child %8phC was already known\n", &ceaddr);
 =09=09list_del(&exchild->node);
+=09=09kfree(exchild);
+=09} else {
+=09=09wpan_dev->nchildren++;
 =09}
=20
 =09list_add(&child->node, &wpan_dev->children);
-=09wpan_dev->nchildren++;
=20
 unlock:
 =09mutex_unlock(&wpan_dev->association_lock);
--=20
2.56.0


