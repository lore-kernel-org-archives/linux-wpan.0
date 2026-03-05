Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2614382298;
	Thu,  5 Mar 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707419; cv=none; b=QGnUS2582nPPCKZgcO0xHZcgu+jt0V/XHct2KO/iVbEawKNrn4v5nqOANxQXrWeFf4DolWE1QBy8pDEwgmboyoG9EXRJL3j3selhYAyppIyDS9yccRU5YiRN96iFRkM4UCHBMVFAhYgAfge4BcqwNrQaFlKt705zPjgK+NHP5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707419; c=relaxed/simple;
	bh=J0gx5pkFYV/6XzaROSpLHxdAdxU1JIU9CsL5W7qI2h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzBxc9RQlUVx1Kt7fy2uaJJyh+14aYRH5QAUVYXD1Q/qHA+1VNL3/lRauv30llhfjRbQR1XoMOxpTeck4Y9pJXxxjGlTgDCAlM0mXsmjf+hnJTbXd+J9NHlDDzRz29s11rll+2mhCzKyPRlX/2bxbQ4hj6iINuBzEbRQ3McZykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I97dWeUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I97dWeUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4505AC116C6;
	Thu,  5 Mar 2026 10:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707419;
	bh=J0gx5pkFYV/6XzaROSpLHxdAdxU1JIU9CsL5W7qI2h0=;
	h=From:To:Cc:Subject:Date:From;
	b=I97dWeUP9+A1t5OUCDW1sdi9GARy1KLgB4LVEUn/Ko4qjImf/TX8fDv+E563BIF0l
	 FVqmG1+MpbwuCrGOP70mgUX9XBN2YL6BGA/h8qPihDe24cCpXjd+BF9/2QSiATyaJk
	 sQqnsy7i/S4A7NP3AE4hEh35xNJP2QpEa8JLgDE6M17FlIz833WTUWOEfq41XI3AJt
	 pJ8+jBJpxk/Up6vyrCJNUerygZcgPvg5l4f1Xv0o4H0/mXbkJHPZvII+EM+dawdmID
	 vTiiGC4CVGujCovs919mSM8QTYB/BAKC615WnOq7f7ls0ieYgG6wrDgWqKgsmTvgFZ
	 /H00bK0ibVCAQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6B7-0000000048v-01Ge;
	Thu, 05 Mar 2026 11:43:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] ieee802154: atusb: drop redundant device reference
Date: Thu,  5 Mar 2026 11:43:13 +0100
Message-ID: <20260305104313.15898-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ieee802154/atusb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 95a4a3cdc8a4..5f7fc4ee7a07 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -961,7 +961,7 @@ static int atusb_probe(struct usb_interface *interface,
 
 	atusb = hw->priv;
 	atusb->hw = hw;
-	atusb->usb_dev = usb_get_dev(usb_dev);
+	atusb->usb_dev = usb_dev;
 	usb_set_intfdata(interface, atusb);
 
 	atusb->shutdown = 0;
@@ -1055,7 +1055,6 @@ static int atusb_probe(struct usb_interface *interface,
 	atusb_free_urbs(atusb);
 	usb_kill_urb(atusb->tx_urb);
 	usb_free_urb(atusb->tx_urb);
-	usb_put_dev(usb_dev);
 	ieee802154_free_hw(hw);
 	return ret;
 }
@@ -1076,8 +1075,6 @@ static void atusb_disconnect(struct usb_interface *interface)
 
 	ieee802154_unregister_hw(atusb->hw);
 
-	usb_put_dev(atusb->usb_dev);
-
 	ieee802154_free_hw(atusb->hw);
 
 	usb_set_intfdata(interface, NULL);
-- 
2.52.0

