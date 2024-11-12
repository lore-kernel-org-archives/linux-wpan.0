Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB523774;
	Tue, 12 Nov 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370937; cv=none; b=JTS2adaH0FbguQvCCP2LXkEUabxZib1ae+1khmOavRiAroc17hq5WWhakyi+zR1BPDAwz2T7fy/lBkzYUmM/kHNzdUM4d1/KxLOBWhfSz5MoTr2lqKNkr5CRL28wFU9ogJ+z2ycWAu2YlMxGFOdabrs0ScOt49uXdc2Z+9H7s8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370937; c=relaxed/simple;
	bh=LJnp9v0q1Yirat/K0CFKBiyXvSDiBm41PbaeT0HMU48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM0dZJSd9ErTN9ImaXKcEdfRBPQHE8AjcYEhmgcMs0m4ETaUC21wfoKc2oSuQgMWfxYYpiYmhsdQEC5Je4mAImgh4j08inuyXUWP/fRM4Og4x3C4Tfn1FEC12/ETvvcYADNLt00YBCzGYCpjzUKTP1ZKJr4RkyhlZ4fcfr4p4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC00CAZ012998;
	Tue, 12 Nov 2024 00:21:40 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42sxq8jcac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Nov 2024 00:21:40 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 16:21:38 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 16:21:35 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <miquel.raynal@bootlin.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <dmantipov@yandex.ru>,
        <edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-wpan@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <stefan@datenfreihafen.org>,
        <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] mac802154: add a check for slave data list before delete
Date: Tue, 12 Nov 2024 08:21:33 +0800
Message-ID: <20241112002134.2003089-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87msi5pn7y.fsf@bootlin.com>
References: <87msi5pn7y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hWFZ7f3jhr-QNd40K2CHu6HHzAWZW-no
X-Proofpoint-ORIG-GUID: hWFZ7f3jhr-QNd40K2CHu6HHzAWZW-no
X-Authority-Analysis: v=2.4 cv=Z+m+H2RA c=1 sm=1 tr=0 ts=67329f94 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8
 a=edf1wS77AAAA:8 a=3x1GYpjDyCIDGwwJR-wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411120001

On Mon, 11 Nov 2024 20:46:57 +0100, Miquel Raynal wrote:
> On 08/11/2024 at 22:54:20 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:
> 
> > syzkaller reported a corrupted list in ieee802154_if_remove. [1]
> >
> > Remove an IEEE 802.15.4 network interface after unregister an IEEE 802.15.4
> > hardware device from the system.
> >
> > CPU0					CPU1
> > ====					====
> > genl_family_rcv_msg_doit		ieee802154_unregister_hw
> > ieee802154_del_iface			ieee802154_remove_interfaces
> > rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
> > ieee802154_if_remove
> > list_del_rcu
> 
> FYI this is a "duplicate" but with a different approach than:
> https://lore.kernel.org/linux-wpan/87v7wtpngj.fsf@bootlin.com/T/#m02cebe86ec0171fc4d3350676bbdd4a7e3827077
No, my patch was the first to fix it, someone else copied my patch. Here is my patch:

From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
Date: Fri, 08 Nov 2024 03:24:46 -0800	[thread overview]
Message-ID: <672df4fe.050a0220.69fce.0011.GAE@google.com> (raw)
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
Author: lizhi.xu@windriver.com

net device has been unregistered ?

#syz test

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..6771c0569516 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -101,6 +101,7 @@ enum {
 
 enum ieee802154_sdata_state_bits {
 	SDATA_STATE_RUNNING,
+	SDATA_STATE_LISTDONE,
 };
 
 /* Slave interface definition.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..95f11d377fd3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -683,6 +683,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	printk("sd: %p, sdl: %p, dev: %p, l: %p, if remove\n", sdata, sdata->list, sdata->dev, sdata->local);
+	if (test_bit(SDATA_STATE_LISTDONE, &sdata->state))
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
@@ -697,7 +701,9 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
+		printk("sd: %p, sdl: %p, dev: %p, l: %p, rmv interfaces\n", sdata, sdata->list, sdata->dev, sdata->local);
 		list_del(&sdata->list);
+		set_bit(SDATA_STATE_LISTDONE, &sdata->state);
 
 		unregister_netdevice(sdata->dev);
 	}
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b280b4..81289719584e 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -279,6 +279,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
+	printk("l: %p unreg hw\n", local);
 	ieee802154_remove_interfaces(local);
 
 	rtnl_unlock();

> 
> Thanks,
> Miquèl
> 
> >
> > Avoid this issue, by adding slave data state bit SDATA_STATE_LISTDONE, set
> > SDATA_STATE_LISTDONE when unregistering the hardware from the system, and
> > add state bit SDATA_STATE_LISTDONE judgment before removing the interface
> > to delete the list.
> >
> > [1]
> > kernel BUG at lib/list_debug.c:58!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 UID: 0 PID: 6277 Comm: syz-executor157 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
> > Code: e8 a1 7e 00 07 90 0f 0b 48 c7 c7 e0 37 60 8c 4c 89 fe e8 8f 7e 00 07 90 0f 0b 48 c7 c7 40 38 60 8c 4c 89 fe e8 7d 7e 00 07 90 <0f> 0b 48 c7 c7 a0 38 60 8c 4c 89 fe e8 6b 7e 00 07 90 0f 0b 48 c7
> > RSP: 0018:ffffc9000490f3d0 EFLAGS: 00010246
> > RAX: 000000000000004e RBX: dead000000000122 RCX: d211eee56bb28d00
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffff88805b278dd8 R08: ffffffff8174a12c R09: 1ffffffff2852f0d
> > R10: dffffc0000000000 R11: fffffbfff2852f0e R12: dffffc0000000000
> > R13: dffffc0000000000 R14: dead000000000100 R15: ffff88805b278cc0
> > FS:  0000555572f94380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000056262e4a3000 CR3: 0000000078496000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __list_del_entry_valid include/linux/list.h:124 [inline]
> >  __list_del_entry include/linux/list.h:215 [inline]
> >  list_del_rcu include/linux/rculist.h:157 [inline]
> >  ieee802154_if_remove+0x86/0x1e0 net/mac802154/iface.c:687
> >  rdev_del_virtual_intf_deprecated net/ieee802154/rdev-ops.h:24 [inline]
> >  ieee802154_del_iface+0x2c0/0x5c0 net/ieee802154/nl-phy.c:323
> >  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
> >  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> >  genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
> >  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
> >  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> >  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
> >  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
> >  sock_sendmsg_nosec net/socket.c:729 [inline]
> >  __sock_sendmsg+0x221/0x270 net/socket.c:744
> >  ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
> >  ___sys_sendmsg net/socket.c:2661 [inline]
> >  __sys_sendmsg+0x292/0x380 net/socket.c:2690
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Reported-and-tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > ---
> >  net/mac802154/ieee802154_i.h | 1 +
> >  net/mac802154/iface.c        | 4 ++++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> > index 08dd521a51a5..6771c0569516 100644
> > --- a/net/mac802154/ieee802154_i.h
> > +++ b/net/mac802154/ieee802154_i.h
> > @@ -101,6 +101,7 @@ enum {
> >
> >  enum ieee802154_sdata_state_bits {
> >  	SDATA_STATE_RUNNING,
> > +	SDATA_STATE_LISTDONE,
> >  };
> >
> >  /* Slave interface definition.
> > diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> > index c0e2da5072be..aed2fc63395d 100644
> > --- a/net/mac802154/iface.c
> > +++ b/net/mac802154/iface.c
> > @@ -683,6 +683,9 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
> >  {
> >  	ASSERT_RTNL();
> >
> > +	if (test_bit(SDATA_STATE_LISTDONE, &sdata->state))
> > +		return;
> > +
> >  	mutex_lock(&sdata->local->iflist_mtx);
> >  	list_del_rcu(&sdata->list);
> >  	mutex_unlock(&sdata->local->iflist_mtx);
> > @@ -698,6 +701,7 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
> >  	mutex_lock(&local->iflist_mtx);
> >  	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
> >  		list_del(&sdata->list);
> > +		set_bit(SDATA_STATE_LISTDONE, &sdata->state);
> >
> >  		unregister_netdevice(sdata->dev);
> >  	}

BR,
Lizhi
