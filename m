Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D89136672;
	Tue, 12 Nov 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418935; cv=none; b=NNHqgx0lZEGYYcebZD1203A+6arj/1vUiqBkcil2oa8mvrD/zS/X5Q1dMnanZsmJnX/pf3YwdxTpQbwX2SBL+GwBTCt1ZYMMIqxt9Di3pk3KIWzqIMFd+cvRa4ts6hfFVnsKBLrC89h3ux7/md1i0Upqzha+A4MHZBdMn+d23Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418935; c=relaxed/simple;
	bh=PmmGq9MQlwiLYwZTwBdlEdx5uxj3+ySLARq/83c36T0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuziEXOJ7Bj7ykkdXn+tqLSdt8K9cy6MWCFaquORZlFCBFHCXw7RValg5JQDQyKPSD90+K8hpMlCz9WGOUiZWIKrSZGr1QLO+7efS8Bil19o5BJ9uaz2DqI/OSXEVAs9xPRIBZr+k2AkfKKE+LY0qBv69k2F69Fvr/bhgOifEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC6c6kS006849;
	Tue, 12 Nov 2024 13:41:51 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwtu8ht0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Nov 2024 13:41:51 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 05:41:50 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 05:41:46 -0800
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
Date: Tue, 12 Nov 2024 21:41:45 +0800
Message-ID: <20241112134145.959501-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87a5e4u35q.fsf@bootlin.com>
References: <87a5e4u35q.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: J9dptWvWvljS2ud7KXkMraB4K31vRfFy
X-Authority-Analysis: v=2.4 cv=BPnhr0QG c=1 sm=1 tr=0 ts=67335b1f cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8
 a=ydFU7h2lCqqN0RIcs4oA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-ORIG-GUID: J9dptWvWvljS2ud7KXkMraB4K31vRfFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=993 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411120111

On Tue, 12 Nov 2024 12:01:21 +0100, Miquel Raynal wrote:
>On 12/11/2024 at 08:21:33 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>
>> On Mon, 11 Nov 2024 20:46:57 +0100, Miquel Raynal wrote:
>>> On 08/11/2024 at 22:54:20 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>>>
>>> > syzkaller reported a corrupted list in ieee802154_if_remove. [1]
>>> >
>>> > Remove an IEEE 802.15.4 network interface after unregister an IEEE 802.15.4
>>> > hardware device from the system.
>>> >
>>> > CPU0					CPU1
>>> > ====					====
>>> > genl_family_rcv_msg_doit		ieee802154_unregister_hw
>>> > ieee802154_del_iface			ieee802154_remove_interfaces
>>> > rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
>>> > ieee802154_if_remove
>>> > list_del_rcu
>>>
>>> FYI this is a "duplicate" but with a different approach than:
>>> https://lore.kernel.org/linux-wpan/87v7wtpngj.fsf@bootlin.com/T/#m02cebe86ec0171fc4d3350676bbdd4a7e3827077
>> No, my patch was the first to fix it, someone else copied my
>> patch. Here is my patch:
>
>Ok, so same question as to the other contributor, why not enclosing the
>remaining list_del_rcu() within mutex protection? Can we avoid the
>creation of the LISTDONE state bit?
From the analysis of the list itself, we can not rely on the newly added state bit. 
The net device has been unregistered, since the rcu grace period,
unregistration must be run before ieee802154_if_remove.

Following is my V2 patch, it has been tested and works well.

From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Tue, 12 Nov 2024 20:59:34 +0800
Subject: [PATCH V2] mac802154: check local interfaces before deleting sdata list

syzkaller reported a corrupted list in ieee802154_if_remove. [1]

Remove an IEEE 802.15.4 network interface after unregister an IEEE 802.15.4
hardware device from the system.

CPU0					CPU1
====					====
genl_family_rcv_msg_doit		ieee802154_unregister_hw
ieee802154_del_iface			ieee802154_remove_interfaces
rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
ieee802154_if_remove
list_del_rcu

The net device has been unregistered, since the rcu grace period,
unregistration must be run before ieee802154_if_remove.

To avoid this issue, add a check for local->interfaces before deleting
sdata list.

[1]
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6277 Comm: syz-executor157 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 a1 7e 00 07 90 0f 0b 48 c7 c7 e0 37 60 8c 4c 89 fe e8 8f 7e 00 07 90 0f 0b 48 c7 c7 40 38 60 8c 4c 89 fe e8 7d 7e 00 07 90 <0f> 0b 48 c7 c7 a0 38 60 8c 4c 89 fe e8 6b 7e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc9000490f3d0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d211eee56bb28d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805b278dd8 R08: ffffffff8174a12c R09: 1ffffffff2852f0d
R10: dffffc0000000000 R11: fffffbfff2852f0e R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88805b278cc0
FS:  0000555572f94380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056262e4a3000 CR3: 0000000078496000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 ieee802154_if_remove+0x86/0x1e0 net/mac802154/iface.c:687
 rdev_del_virtual_intf_deprecated net/ieee802154/rdev-ops.h:24 [inline]
 ieee802154_del_iface+0x2c0/0x5c0 net/ieee802154/nl-phy.c:323
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-and-tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: remove state bit and add a check for local interfaces before
          deleting sdata list

 net/mac802154/iface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..9e4631fade90 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -684,6 +684,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
+	if (list_empty(&sdata->local->interfaces)) {
+		mutex_unlock(&sdata->local->iflist_mtx);
+		return;
+	}
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-- 
2.43.0

