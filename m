Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A6201113;
	Tue, 29 Oct 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226480; cv=none; b=uBD8HLDKxDpUOLM92Nm2xHG6kbT2gwPKRLghEeM/fVVCQ+kl/VYRAgR+HX+FNfeilfWE9ScGs2bafsbIuGVSu4hrN2RDkmDcU+Z/vbmPL2sZ2K9klhnx++JsPElcIaJAUra/Mai4eNI4nlpG3Tr6iJ/gxaqY8RSgUCFeXa8K2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226480; c=relaxed/simple;
	bh=iZZNH1oCnQp4U4/xizHEk4wh5CR9n6xPLWwU1NfD2fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rameCo/SvEY3E+M4IHg3XfAd39MYUw6XrXegSaKOQg5TjMCZNmIE1h1ECopu5e5tP2xG8+/YG9x59iRG2s5WfHhE4Q4BejIlgTR4dh/QptC2c7hDa7eC47vDqabX+3vqxE5T6VL5i8kn3LiqTbu+teCCsvAatO1fzkZHhhaGdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=LufJeo/P; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="LufJeo/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wMEqgI/d0sXDYhU5GRNop0Deaej+tyEHNlqS/HqWcoA=;
  b=LufJeo/PgFU88e2sJsvHLTKUKkjwMxbmnVmA8N+BW6/TutR/Gbb7ikKr
   orHmGt+pdZk6JbrOabvjLjlOThyDQCI6UGZ6mU0Fq21dp+kPcG92sgRdn
   z4J1L8ryLU1p06PckQOcrX14gunGAf6xTKqJQpQVK80j06AJLxw77A/Gc
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,241,1725314400"; 
   d="scan'208";a="191328207"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.tailde312.ts.net) ([128.93.67.66])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:27:49 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH] ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()
Date: Tue, 29 Oct 2024 19:27:12 +0100
Message-Id: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ca8210_test_interface_init() returns the result of kfifo_alloc(),
which can be non-zero in case of an error. The caller, ca8210_probe(),
should check the return value and do error-handling if it fails.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
---
 drivers/net/ieee802154/ca8210.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index e685a7f946f0..753215ebc67c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3072,7 +3072,11 @@ static int ca8210_probe(struct spi_device *spi_device)
 	spi_set_drvdata(priv->spi, priv);
 	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
 		cascoda_api_upstream = ca8210_test_int_driver_write;
-		ca8210_test_interface_init(priv);
+		ret = ca8210_test_interface_init(priv);
+		if (ret) {
+			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
+			goto error;
+		}
 	} else {
 		cascoda_api_upstream = NULL;
 	}
-- 
2.34.1

