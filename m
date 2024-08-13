Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5041C287;
	Tue, 13 Aug 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578785; cv=none; b=Dbv9Pyr43XjZr8sXukhvhsq2ZSKRpfuVxp0xCA7Noj0wdhUsPX5e2rDEDMX0AeXwBdckfoBMybTMX5uGXdYQuNqa24T44qa2qzkz7Hy96LEXwBhKccsMdx+P0WQsIB24UIt3r1hWYvfFb9Mi6l4hlvcGyexBLFcx388AwA98lrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578785; c=relaxed/simple;
	bh=u8azd52hcgNwadO9/+lnq74JXjt/FATQutSvfuZ5SNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg4Xn90go8DuE83mbtoscWgQ9n8gBqlVfeSyWA15T3qNDxrlyMVJIJI2E9UYiFDThoeRK9ffzAW29mb5b/0W+mZN38FyMOK19znPQurdsTbpmC8imdabMtORp1xSYJ9FL3ue7WYe3lHHLk0OHqaOGoV+LhQIghJ4one/EvPx7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qFeqBTuN; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qFeqBTuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723578784; x=1755114784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+shor+OzxsCmcctq1mFydd9s6unzmpHSdyiC8OC4HD0=;
  b=qFeqBTuNUUjssvzHYMQdl81R2dTSWn+OuUOFA02C7lLQ5/qMfVRRLhzH
   nJEMnbw30pXLvN/giPPzdfavuQX0wWORC200ALmqvg2AHEhERi3yDwPoW
   +aWI6te8ly5b54Ra/o3bLy9y1ALnF9UVpDeoMksnDQUhqAhWLt3VqrYZs
   M=;
X-IronPort-AV: E=Sophos;i="6.09,286,1716249600"; 
   d="scan'208";a="362106529"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 19:52:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:24099]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with esmtp (Farcaster)
 id 152d6685-bac2-4119-b626-a486ea676ec8; Tue, 13 Aug 2024 19:52:55 +0000 (UTC)
X-Farcaster-Flow-ID: 152d6685-bac2-4119-b626-a486ea676ec8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 19:52:55 +0000
Received: from 88665a182662.ant.amazon.com (10.119.205.65) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 19:52:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stefan@datenfreihafen.org>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (2)
Date: Tue, 13 Aug 2024 12:52:44 -0700
Message-ID: <20240813195244.23260-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000f4a1b7061f9421de@google.com>
References: <000000000000f4a1b7061f9421de@google.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
Date: Tue, 13 Aug 2024 10:42:25 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ee9a43b7cfe2 Merge tag 'net-6.11-rc3' of git://git.kernel...
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=13da25d3980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
> dashboard link: https://syzkaller.appspot.com/bug?extid=e0bd4e4815a910c0daa8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

kstrdup() failed due to fault injection.

We may want to change the WARN_ON(1) in these functions
to net_warn_ratelimited() as we do so in do_setlink().

  * __dev_change_net_namespace
  * cfg802154_switch_netns
  * cfg80211_switch_netns()

[  141.438766][ T8054] FAULT_INJECTION: forcing a failure.
[  141.438766][ T8054] name failslab, interval 1, probability 0, space 0, times 0
[  141.453868][ T8054] CPU: 1 UID: 0 PID: 8054 Comm: syz.0.839 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2 #0
[  141.464514][ T8054] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
[  141.474602][ T8054] Call Trace:
[  141.477906][ T8054]  <TASK>
[  141.480854][ T8054]  dump_stack_lvl+0x241/0x360
[  141.507418][ T8054]  should_fail_ex+0x3b0/0x4e0
[  141.512110][ T8054]  should_failslab+0xac/0x100
[  141.516785][ T8054]  __kmalloc_node_track_caller_noprof+0xda/0x440
[  141.523098][ T8054]  ? device_rename+0xb5/0x1b0
[  141.527767][ T8054]  kstrdup+0x3a/0x80
[  141.531651][ T8054]  device_rename+0xb5/0x1b0
[  141.536142][ T8054]  cfg802154_switch_netns+0x1df/0x390
[  141.541523][ T8054]  nl802154_wpan_phy_netns+0x13d/0x210
[  141.546984][ T8054]  genl_rcv_msg+0xb14/0xec0
[...]
[  141.801010][ T8054]  </TASK>
[  141.865238][ T8054] ------------[ cut here ]------------
[  141.871127][ T8054] WARNING: CPU: 1 PID: 8054 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x37f/0x390
