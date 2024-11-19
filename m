Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF561C1F33;
	Tue, 19 Nov 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011308; cv=none; b=f9YzdlT+U/pqgIddtfz4ismMfDZdsOygNO+3SF6X8rMwAFsldV1XUrWo4hCy2yVi2KWIKc8PjD727kQ2sEcanfT+fV5K8epF9KvzY71zKowAUwfVa32QBOFNPGgqHsCDwESqzgoaZX1mfcPBrNpU0+P40KaXgocorVsV6QSQ1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011308; c=relaxed/simple;
	bh=2BhQJ7dhkXTbkhp47FG7gzm1YR+h+s0GV5pCi2MUGBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4RghQUSD7EiNIBwkX0xX7LyUsG6iGuJvoWlN29rttQPcBimjirksW45veH1jOAbjZRZhYosk07nmYmW59kJ8vkOvFh0QtVy4dPXEUkURKc8aOEFNKmus+zPPSQG0IJ7go3ODp5SL/PHeKKD+0brgGNdxj32uMmFN/xd3EtZ21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 8CC7DC0A83;
	Tue, 19 Nov 2024 11:07:13 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: miquel.raynal@bootlin.com,
	Lizhi Xu <lizhi.xu@windriver.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	alex.aring@gmail.com,
	davem@davemloft.net,
	dmantipov@yandex.ru,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] mac802154: check local interfaces before deleting sdata list
Date: Tue, 19 Nov 2024 11:06:47 +0100
Message-ID: <173201035744.581024.1274612983499163001.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113095129.1457225-1-lizhi.xu@windriver.com>
References: <87plmzsfog.fsf@bootlin.com> <20241113095129.1457225-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Lizhi Xu.

On Wed, 13 Nov 2024 17:51:29 +0800, Lizhi Xu wrote:
> syzkaller reported a corrupted list in ieee802154_if_remove. [1]
> 
> Remove an IEEE 802.15.4 network interface after unregister an IEEE 802.15.4
> hardware device from the system.
> 
> CPU0					CPU1
> ====					====
> genl_family_rcv_msg_doit		ieee802154_unregister_hw
> ieee802154_del_iface			ieee802154_remove_interfaces
> rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
> ieee802154_if_remove
> list_del_rcu
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: check local interfaces before deleting sdata list
      https://git.kernel.org/wpan/wpan/c/eb09fbeb4870

regards,
Stefan Schmidt
