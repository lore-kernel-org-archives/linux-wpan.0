Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA61D54FE;
	Thu, 14 Nov 2024 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547060; cv=none; b=FUgO9B3/HrvH53Z2UyrSZnaYdwLiOvZOuU2pbLk9SGVkJQHj5E99zK/bS3C42wx5pRhNw/Qvv3gs0vW15O5z1uRycuT+fDAesBn7uYBj5zb9ABRrJPn2Kf/7esT2T968L4yqHSUhbdzt72DMpR/cRUPfMeCC8aWlUWGtCvSnSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547060; c=relaxed/simple;
	bh=o4npxX6gfTKYDKFakWYLsF0YGp/i5nXfFpX5sGLtVPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMbde0OdBpKdgaEcAekwXTS17hvYBATWgJ3TdG/zN7gdSsMSv1joeg34Z119tT9wjuM0LPDphbuKLcB2nhT1S4CQmt87cJzvHPRN83gtof0hTAr0xVBVQbYJYlHYrz+IrqoR8YsCHwkgPWiLYbVRKtOCW/LagUTJZmEQ2NeibMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE0dgSs018597;
	Wed, 13 Nov 2024 17:17:13 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwpmjtb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Nov 2024 17:17:13 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 13 Nov 2024 17:17:12 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 13 Nov 2024 17:17:08 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <dmantipov@yandex.ru>,
        <edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <stefan@datenfreihafen.org>,
        <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] mac802154: add a check for slave data list before delete
Date: Thu, 14 Nov 2024 09:17:08 +0800
Message-ID: <20241114011708.3420819-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114010025.3390836-1-lizhi.xu@windriver.com>
References: <20241114010025.3390836-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qUHfnZFI8ih3WUYLQIHO0ADb1963tMNQ
X-Authority-Analysis: v=2.4 cv=ZdlPNdVA c=1 sm=1 tr=0 ts=67354f99 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=edf1wS77AAAA:8 a=1qqy2SNDD57gUU2HqXEA:9 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-ORIG-GUID: qUHfnZFI8ih3WUYLQIHO0ADb1963tMNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_17,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=550 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411140007

On Thu, 14 Nov 2024 09:00:25 +0800, Lizhi Xu wrote:
> On Wed, 13 Nov 2024 13:29:55 +0300, Dmitry Antipov wrote:
> > On 11/12/24 4:41 PM, Lizhi Xu wrote:
> >
> > >   	mutex_lock(&sdata->local->iflist_mtx);
> > > +	if (list_empty(&sdata->local->interfaces)) {
> > > +		mutex_unlock(&sdata->local->iflist_mtx);
> > > +		return;
> > > +	}
> > >   	list_del_rcu(&sdata->list);
> > >   	mutex_unlock(&sdata->local->iflist_mtx);
> >
> > Note https://syzkaller.appspot.com/text?tag=ReproC&x=12a9f740580000 makes an
> > attempt to connect the only device. How this is expected to work if there are
> > more than one device?
> There are two locks (rtnl and iflist_mtx) to protection and synchronization
> local->interfaces, so no need to worry about multiple devices.
In other words, this case is a race between removing the 802154 master
and the user sendmsg actively deleting the slave.
Then when the master is removed, there is no need to execute the latter to
remove the slave, because all the slave devices have been deleted when the
master device is removed..

Lizhi
